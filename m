Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A50644862
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiLFPvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 10:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiLFPuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 10:50:44 -0500
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F02DA9A;
        Tue,  6 Dec 2022 07:50:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C15B0671E6;
        Tue,  6 Dec 2022 15:41:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo07-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo07-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7KNxY2pcsAa; Tue,  6 Dec 2022 15:41:49 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id 4FBC2671CD;
        Tue,  6 Dec 2022 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 64C783EEF3;
        Tue,  6 Dec 2022 08:41:48 -0700 (MST)
From:   Khalid Aziz <khalid@gonehiking.org>
To:     akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid@gonehiking.org>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, 21cnbao@gmail.com,
        arnd@arndb.de, ebiederm@xmission.com, elver@google.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, khalid.aziz@oracle.com
Subject: [RFC PATCH 0/2] Add support for sharing page tables across processes (Previously mshare)
Date:   Tue,  6 Dec 2022 08:41:39 -0700
Message-Id: <cover.1670287695.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Previously mshare patches. After discussion on mailing list and at
LSF/MM, mshare implementation has been reworked to eliminate the
mshare API and use mmap instead with a new flag. This eliminates the
need for msharefs. Alignment and size restrictions were changed to
PMD]


Memory pages shared between processes require a page table entry
(PTE) for each process. Each of these PTE consumes consume some of
the memory and as long as number of mappings being maintained is
small enough, this space consumed by page tables is not
objectionable. When very few memory pages are shared between
processes, the number of page table entries (PTEs) to maintain is
mostly constrained by the number of pages of memory on the system.
As the number of shared pages and the number of times pages are
shared goes up, amount of memory consumed by page tables starts to
become significant. This issue does not apply to threads. Any number
of threads can share the same pages inside a process while sharing
the same PTEs. Extending this same model to sharing pages across
processes can eliminate this issue for sharing across processes as
well.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is only 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, amount of memory saved is very significant.

This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
This map can be specified along with MAP_SHARED by a process to hint
to kernel that it wishes to share page table entries for this file
mapping mmap region with other processes. Any other process that
mmaps the same file with MAP_SHARED_PT flag can then share the same
page table entries. Besides specifying MAP_SHARED_PT flag, the
processes must map the files at a PMD aligned address with a size
that is a multiple of PMD size and at the same virtual addresses.
This last requirement of same virtual addresses can possibly be
relaxed if that is the consensus.

When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
is created to hold the shared page tables. Host mm struct is not
attached to a process. Start and size of host mm are set to the
start and size of the mmap region and a VMA covering this range is
also added to host mm struct. Existing page table entries from the
process that creates the mapping are copied over to the host mm
struct. All processes mapping this shared region are considered
guest processes. When a guest process mmap's the shared region, a vm
flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
flag is found, its corresponding PMD is updated with the PMD from
host mm struct so the PMD will point to the page tables in host mm
struct. vm_mm pointer of the VMA is also updated to point to host mm
struct for the duration of fault handling to ensure fault handling
happens in the context of host mm struct. When a new PTE is
created, it is created in the host mm struct page tables and the PMD
in guest mm points to the same PTEs.

This is a basic working implementation. It will need to go through
more testing and refinements. Some notes and questions:

- PMD size alignment and size requirement is currently hard coded
  in. Is there a need or desire to make this more flexible and work
  with other alignments/sizes? PMD size allows for adapting this
  infrastructure to form the basis for hugetlbfs page table sharing
  as well. More work ill be needed to make that happen.

- Is there a reason to allow a userspace app to query this size and
  alignment requirement for MAP_SHARED_PT in some way?

- Shared PTEs means mprotect() call made by one process affects all
  processes sharing the same mapping and that behavior will need to
  be documented clearly. Effect of mprotect call being different for
  processes using shared page tables is the primary reason to
  require an explicit opt-in from userspace processes to share page
  tables. With a transparent sharing derived from MAP_SHARED alone,
  changed effect of mprotect can break significant number of
  userspace apps. One could work around that by unsharing whenever
  mprotect changes modes on shared mapping but that introduces
  complexity and the capability to execute a single mprotect to
  change modes across 1000's of processes sharing a mapped database
  is a feature explicitly asked for by database folks. This
  capability has significant performance advantage when compared to
  mechanism of sending messages to every process using shared
  mapping to call mprotect and change modes in each process, or
  using traps on permissions mismatch in each process.

- This implementation does not allow unmapping page table shared
  mappings partially. Should that be supported in future?

- Patch 2 will be broken up into smaller patches after RFC. It
  likely is easier to review the proposal with all code in one patch
  for now.


Khalid Aziz (2):
  mm/ptshare: Add vm flag for shared PTE
  mm/ptshare: Create a new mm to share pagetables

 include/linux/fs.h                     |   1 +
 include/linux/mm.h                     |   8 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |  21 ++
 mm/memory.c                            |  52 ++++-
 mm/mmap.c                              |  87 ++++++++
 mm/ptshare.c                           | 262 +++++++++++++++++++++++++
 9 files changed, 433 insertions(+), 4 deletions(-)
 create mode 100644 mm/ptshare.c

-- 
2.34.1

