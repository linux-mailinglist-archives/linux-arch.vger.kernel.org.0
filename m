Return-Path: <linux-arch+bounces-11252-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE079A7B5B1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 04:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7680316C254
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9EE2E62B5;
	Fri,  4 Apr 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLsYLooY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AC54764;
	Fri,  4 Apr 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733188; cv=none; b=WH/20O9ztFwkOTSSSbBJ3fmRAmycUtP8mz/9kLZjU2jf2o8ZyzkSwVJeabIkeyCecOj/cbHb3cUHVkVxQIfPmz36VqSKpjfm1Qq9zN0fumY1T/14n0PeZUCwG1/H7NpR1RR7HYWsbqXub8XLpxagtI8H39s5vB0Lpa50YsHhu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733188; c=relaxed/simple;
	bh=xcLlqd7qF6K1f4edc/l7PSEoBeZczNHz5Npt5oM+qoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b26qmslp7xFsYm7+Ff4+o/wPSSvuNsULSq5vzKY+46ea2iiPrEjqrajTVKRaTAfoOEV22O6Zj2P2jJdsWbcO+5UAGO/LusOiTwoRgjPJzRxqTNRmXEsvEnGhSV3Mrxpljf+g96NQ23zuy+kLcgz2GToRduTbI5K2X4OlrAbTL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLsYLooY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341Nuhg001155;
	Fri, 4 Apr 2025 02:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=8YrBsw5n/2Gu317TtpDDmsLHhH+FL
	h8PCv2dLcFMr8E=; b=lLsYLooYGjyx4TtetP9NgdP2bP+xwdP3rHaaIRxv8eaou
	dBKnupHa/RfWo3laIFy7hRBZwnJor7FLRNvf0buTzf4B21DYS2TgP2apJp3IFSMc
	EJvfOCBCuKVCD+aM3OAgI62nUk9cvV6MhQqONPO46EiiObBFwgHprqQ6F3BsYzCb
	T99ymP9DknZbHcj9NnNTVxw3t0Y5tQs9NcqBBge9zFdkI+SV2xcOQgiuh0Vd6qnJ
	sLJ5OFpv8PbmvOS1GWu8CfgqlcO+knVM5W1tQ9XHxkbstceEU1yQg7BZzfCcy6Ew
	lVu2bItBAromak6zGpdVOmVLnXBf2hJ0tb0fkrLIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcpnpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5340eutt017397;
	Fri, 4 Apr 2025 02:19:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pspj7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 02:19:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5342H8ga030074;
	Fri, 4 Apr 2025 02:19:05 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 45t2pspj73-1;
	Fri, 04 Apr 2025 02:19:05 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org
Cc: anthony.yznaga@oracle.com, andreyknvl@gmail.com, dave.hansen@intel.com,
        luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: [PATCH v2 00/20] Add support for shared PTEs across processes
Date: Thu,  3 Apr 2025 19:18:42 -0700
Message-ID: <20250404021902.48863-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040014
X-Proofpoint-GUID: vcCQ_I---la9ErYfw2XkNTh7u537Tf9B
X-Proofpoint-ORIG-GUID: vcCQ_I---la9ErYfw2XkNTh7u537Tf9B

Memory pages shared between processes require page table entries
(PTEs) for each process. Each of these PTEs consume some of
the memory and as long as the number of mappings being maintained
is small enough, this space consumed by page tables is not
objectionable. When very few memory pages are shared between
processes, the number of PTEs to maintain is mostly constrained by
the number of pages of memory on the system. As the number of shared
pages and the number of times pages are shared goes up, amount of
memory consumed by page tables starts to become significant. This
issue does not apply to threads. Any number of threads can share the
same pages inside a process while sharing the same PTEs. Extending
this same model to sharing pages across processes can eliminate this
issue for sharing across processes as well.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, the a substantial amount of memory saved.

This patch series implements a mechanism that allows userspace
processes to opt into sharing PTEs. It adds a new in-memory
filesystem - msharefs. A file created on msharefs represents a
shared region where all processes mapping that region will map
objects within it with shared PTEs. When the file is created,
a new host mm struct is created to hold the shared page tables
and vmas for objects later mapped into the shared region. This
host mm struct is associated with the file and not with a task.
When a process mmap's the shared region, a vm flag VM_MSHARE
is added to the vma. On page fault the vma is checked for the
presence of the VM_MSHARE flag. If found, the host mm is
searched for a vma that covers the fault address. Fault handling
then continues using that host vma which establishes PTEs in the
host mm. Fault handling in a shared region also links the shared
page table to the process page table if the shared page table
already exists.

Ioctls are used to map and unmap objects in the shared region and
to (eventually) perform other operations on the shared objects such
as changing protections.

API
===

The steps to use this feature are:

1. Mount msharefs on /sys/fs/mshare -
        mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. The start
   address for the region must be aligned to an address boundary and
   be a multiple of fixed size. This alignment and size requirement
   can be obtained by reading the file /sys/fs/mshare/mshare_info
   which returns a number in text format. mshare regions must be
   aligned to this boundary and be a multiple of this size.

3. For the process creating an mshare region:
        a. Create a file on /sys/fs/mshare, for example -
                fd = open("/sys/fs/mshare/shareme",
                                O_RDWR|O_CREAT|O_EXCL, 0600);

        b. Establish the size of the region
                ftruncate(fd, BUFFER_SIZE);

        c. Map some memory in the region
                struct mshare_create mcreate;

                mcreate.region_offset = 0;
                mcreate.size = BUFFER_SIZE;
                mcreate.offset = 0;
                mcreate.prot = PROT_READ | PROT_WRITE;
                mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
                mcreate.fd = -1;

                ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

        d. Map the mshare region into the process
                mmap((void *)TB(2), BUFFER_SIZE, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);

        e. Write and read to mshared region normally.

4. For processes attaching an mshare region:
        a. Open the file on msharefs, for example -
                fd = open("/sys/fs/mshare/shareme", O_RDWR);

        b. Get information about mshare'd region from the file:
                struct stat sb;

                fstat(fd, &sb);
                mshare_size = sb.st_size;

        c. Map the mshare'd region into the process
                mmap((void *)TB(2), mshare_size, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);

5. To delete the mshare region -
                unlink("/sys/fs/mshare/shareme");



Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        struct mshare_create mcreate;

        fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
        read(fd, req, 128);
        alignsize = atoi(req);
        close(fd);
        fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
        start = alignsize * 4;
        size = alignsize * 2;

        ftruncate(fd, size);

        mcreate.region_offset = 0;
        mcreate.size = size;
        mcreate.offset = 0;
        mcreate.prot = PROT_READ | PROT_WRITE;
        mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
        mcreate.fd = -1;
        ret = ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
        if (ret < 0)
                perror("ERROR: MSHAREFS_CREATE_MAPPING");

        addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
                        MAP_FIXED | MAP_SHARED, fd, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        strncpy(addr, "Some random shared text",
                        sizeof("Some random shared text"));
-----------------

Snippet of code that a consumer process would execute looks like:

-----------------
        fd = open("/sys/fs/mshare/shareme", O_RDONLY);

        fstat(fd, &sb);
        size = sb.st_size;

        if (!size)
                perror("ERROR: mshare region not init'd");

        addr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
        printf("\nDone\n");

-----------------

v2:
  - Based on mm-unstable as of 2025-04-03 (8ff02705ba8f)
  - Set mshare size via fallocate or ftruncate instead of MSHAREFS_SET_SIZE.
    Removed MSHAREFS_SET_SIZE/MSHAREFS_GET_SIZE ioctls. Use stat to get size.
    (David H)
  - Remove spinlock from mshare_data. Initializing the size is protected by
    the inode lock.
  - Support mapping a single mshare region at different virtual addresses.
  - Support system selection of the start address when mmap'ing an mshare
    region.
  - Changed MSHAREFS_CREATE_MAPPING and MSHAREFS_UNMAP to use a byte offset
    to specify the start of a mapping.
  - Updated documentation.

v1:
  (https://lore.kernel.org/linux-mm/20250124235454.84587-1-anthony.yznaga@oracle.com/)
  - Based on mm-unstable mm-hotfixes-stable-2025-01-16-21-11
  - Use mshare size instead of start address to check if mshare region
    has been initialized.
  - Share page tables at PUD level instead of PGD.
  - Rename vma_is_shared() to vma_is_mshare() (James H / David H)
  - Introduce and use mmap_read_lock_nested() (Kirill)
  - Use an mmu notifier to flush all TLBs when updating shared pagetable
    mappings. (Dave Hansen)
  - Move logic for finding the shared vma to use to handle a fault from
    handle_mm_fault() to do_user_addr_fault() because the arch-specific
    fault handling checks vma flags for access permissions.
  - Add CONFIG_MSHARE / ARCH_SUPPORTS_MSHARE
  - Add msharefs_get_unmapped_area()
  - Implemented vm_ops->unmap_page_range (Kirill)
  - Update free_pgtables/free_pgd_range to free process pagetable levels
    but not shared pagetable levels.
  - A first take at cgroup support

RFC v2 -> v3:
  - Now based on 6.11-rc5
  - Addressed many comments from v2.
  - Simplified filesystem code. Removed refcounting of the
    shared mm_struct allocated for an mshare file. The mm_struct
    and the pagetables and mappings it contains are freed when
    the inode is evicted.
  - Switched to an ioctl-based interface. Ioctls implemented
    are used to set and get the start address and size of an
    mshare region and to map objects into an mshare region
    (only anon shared memory is supported in this series).
  - Updated example code

[1] v2: https://lore.kernel.org/linux-mm/cover.1656531090.git.khalid.aziz@oracle.com/

RFC v1 -> v2:
  - Eliminated mshare and mshare_unlink system calls and
    replaced API with standard mmap and unlink (Based upon
    v1 patch discussions and LSF/MM discussions)
  - All fd based API (based upon feedback and suggestions from
    Andy Lutomirski, Eric Biederman, Kirill and others)
  - Added a file /sys/fs/mshare/mshare_info to provide
    alignment and size requirement info (based upon feedback
    from Dave Hansen, Mark Hemment and discussions at LSF/MM)
  - Addressed TODOs in v1
  - Added support for directories in msharefs
  - Added locks around any time vma is touched (Dave Hansen)
  - Eliminated the need to point vm_mm in original vmas to the
    newly synthesized mshare mm
  - Ensured mmap_read_unlock is called for correct mm in
    handle_mm_fault (Dave Hansen)

Anthony Yznaga (13):
  mm/mshare: allocate an mm_struct for msharefs files
  mm/mshare: add ways to set the size of an mshare region
  mm/mshare: flush all TLBs when updating PTEs in an mshare range
  sched/numa: do not scan msharefs vmas
  mm: add mmap_read_lock_killable_nested()
  mm: add and use unmap_page_range vm_ops hook
  x86/mm: enable page table sharing
  mm: create __do_mmap() to take an mm_struct * arg
  mm: pass the mm in vma_munmap_struct
  mm/mshare: Add an ioctl for unmapping objects in an mshare region
  mm/mshare: provide a way to identify an mm as an mshare host mm
  mm/mshare: get memcg from current->mm instead of mshare mm
  mm/mshare: associate a mem cgroup with an mshare file

Khalid Aziz (7):
  mm: Add msharefs filesystem
  mm/mshare: pre-populate msharefs with information file
  mm/mshare: make msharefs writable and support directories
  mm/mshare: Add a vma flag to indicate an mshare region
  mm/mshare: Add mmap support
  mm/mshare: prepare for page table sharing support
  mm/mshare: Add an ioctl for mapping objects in an mshare region

 Documentation/filesystems/index.rst           |   1 +
 Documentation/filesystems/msharefs.rst        |  96 +++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 arch/Kconfig                                  |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/mm/fault.c                           |  48 +-
 include/linux/memcontrol.h                    |   3 +
 include/linux/mm.h                            |  56 ++
 include/linux/mm_types.h                      |   2 +
 include/linux/mmap_lock.h                     |   7 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/linux/magic.h                    |   1 +
 include/uapi/linux/msharefs.h                 |  38 +
 ipc/shm.c                                     |  17 +
 kernel/sched/fair.c                           |   3 +-
 mm/Kconfig                                    |   9 +
 mm/Makefile                                   |   4 +
 mm/hugetlb.c                                  |  25 +
 mm/memcontrol.c                               |   3 +-
 mm/memory.c                                   |  81 +-
 mm/mmap.c                                     |  10 +-
 mm/mshare.c                                   | 785 ++++++++++++++++++
 mm/vma.c                                      |  22 +-
 mm/vma.h                                      |   3 +-
 24 files changed, 1176 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 include/uapi/linux/msharefs.h
 create mode 100644 mm/mshare.c

-- 
2.43.5


