Return-Path: <linux-arch+bounces-6978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7796ACC7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882F51F255F4
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5637126C13;
	Tue,  3 Sep 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MrJM6J9U"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F430126C07;
	Tue,  3 Sep 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405807; cv=none; b=CaCmQ6OWqr788CXDhmJHKz9xfL3JdBG+Pam81HyCS1uM+YaJ0x8u77WngbFudwbxE3mLXEhZ0Dckd/tXTWecc1G1o2joi4bAu+CDvjwmciWosm8VNx8VzDCo1WJuTTvtlnyISN89QVhP+MlaKwKqMWM8+fQqDfnhLqu/cNavAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405807; c=relaxed/simple;
	bh=gPynKiY76/QXP96z2OqbVSmP0mbhV3qDs6EgEAYbzMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8cvVKb1moHLp2kooBrJ1krvv06f1vHvsMuK2CeBPuHd9Vp++QySpyCofrvdLwwiIEXIof+Gn1aaiO3Zn8o0vSkQ2Dsj0I2KNYenCKYlsDPdzNLJwmKCDbTVDHwYxiEMGbkUJVhVK9t82bTVPUf4N4xh15RT5/Oq0k7UdBbTy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MrJM6J9U; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LBjOI023355;
	Tue, 3 Sep 2024 23:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=sqhlWC7QYGALrW
	O7LRS9RO6c765e3VFDIo0lUrDLc2o=; b=MrJM6J9UNmdBNv1ViegSH0xnsig6xZ
	8Jc6JSnmymTaYOGIkla75NFCpjnOBjxau40Oz51e4vYmCqcUeHuAbp0euVY150dZ
	rvXejeYNKpOXMbZPyN7Qowwh3qP8TvJJCYYOPbGkWNsTOQub83sn7osI+vDIWTDI
	NBS7meBaJiq7bWyTsNTN87t24suYRH6pKPowi45f6RfosYmwZFLJ0nnh3ipz4kdE
	Yz8OkxwiOez9ykp8/6dLKQah+oOji4GJldGC/pxkwR9F+aTP1YkP0nJ5dEaKrdZK
	pyZuF6p3aL8cPqKfUU5lxHKpqbuNgSIEPr6neFZcDQRF7PkAcyqCVD2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jtft6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:22:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483Kvxu2002074;
	Tue, 3 Sep 2024 23:22:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfmmxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:22:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 483NMkf6040456;
	Tue, 3 Sep 2024 23:22:46 GMT
Received: from localhost.us.oracle.com (dhcp-10-159-133-114.vpn.oracle.com [10.159.133.114])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmfmmwr-1;
	Tue, 03 Sep 2024 23:22:46 +0000
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
Subject: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
Date: Tue,  3 Sep 2024 16:22:31 -0700
Message-ID: <20240903232241.43995-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_11,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=787 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030186
X-Proofpoint-GUID: Tfo4ob4NSyrYdu_2yOuqccVjS1vp51LO
X-Proofpoint-ORIG-GUID: Tfo4ob4NSyrYdu_2yOuqccVjS1vp51LO

[Note: I have taken on the mshare work from Khalid. This series
is a continuation of the series last sent out in 2022[1] and not
of the later ptshare series.]

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
When a process mmap's the shared region, a vm flag VM_SHARED_PT
is added to the vma. On page fault the vma is checked for the
presence of the VM_SHARED_PT flag. If found, the host mm is
searched for a vma that covers the fault address. Fault handling
then continues using that host vma which establishes PTEs in the
host mm. Fault handling in a shared region also links the shared
page table to the process page table if the shared page table
already exists.

Ioctls are used to set/get the start address and size of the host
mm, to map objects into the shared region, and to (eventually)
perform other operations on the shared objects such as changing
protections.

One major issue to address for this series to function correctly
is how to ensure proper TLB flushing when a page in a shared
region is unmapped. For example, since the rmaps for pages in a
shared region map back to host vmas which point to a host mm, TLB
flushes won't be directed to the CPUs the sharing processes have
run on. I am by no means an expert in this area. One idea is to
install a mmu_notifier on the host mm that can gather the necessary
data and do flushes similar to the batch flushing.


API
===

mshare does not introduce a new API. It instead uses existing APIs
to implement page table sharing. The steps to use this feature are:

1. Mount msharefs on /sys/fs/mshare -
        mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. Start
   address for the region must be aligned to an address boundary and
   be a multiple of fixed size. This alignment and size requirement
   can be obtained by reading the file /sys/fs/mshare/mshare_info
   which returns a number in text format. mshare regions must be
   aligned to this boundary and be a multiple of this size.

3. For the process creating an mshare region:
        a. Create a file on /sys/fs/mshare, for example -
                fd = open("/sys/fs/mshare/shareme",
                                O_RDWR|O_CREAT|O_EXCL, 0600);

        b. Establish the starting address and size of the region
                struct mshare_info minfo;

                minfo.start = TB(2);
                minfo.size = BUFFER_SIZE;
                ioctl(fd, MSHAREFS_SET_SIZE, &minfo)

        c. Map some memory in the region
                struct mshare_create mcreate;

                mcreate.addr = TB(2);
                mcreate.size = BUFFER_SIZE;
                mcreate.offset = 0;
                mcreate.prot = PROT_READ | PROT_WRITE;
                mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
                mcreate.fd = -1;

                ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate)

        d. Map the mshare region into the process
                mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);

        e. Write and read to mshared region normally.

4. For processes attaching an mshare region:
        a. Open the file on msharefs, for example -
                fd = open("/sys/fs/mshare/shareme", O_RDWR);

        b. Get information about mshare'd region from the file:
                struct mshare_info minfo;

                ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
        
        c. Map the mshare'd region into the process
                mmap(minfo.start, minfo.size,
                        PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

5. To delete the mshare region -
                unlink("/sys/fs/mshare/shareme");



Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        struct mshare_info minfo;
        struct mshare_create mcreate;

        fd = open("/sys/fs/mshare/mshare_info", O_RDONLY);
        read(fd, req, 128);
        alignsize = atoi(req);
        close(fd);
        fd = open("/sys/fs/mshare/shareme", O_RDWR|O_CREAT|O_EXCL, 0600);
        start = alignsize * 4;
        size = alignsize * 2;

        minfo.start = start;
        minfo.size = size;
        ret = ioctl(fd, MSHAREFS_SET_SIZE, &minfo);
        if (ret < 0)
                perror("ERROR: MSHAREFS_SET_SIZE");

        mcreate.addr = start;
        mcreate.size = size;
        mcreate.offset = 0;
        mcreate.prot = PROT_READ | PROT_WRITE;
        mcreate.flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED;
        mcreate.fd = -1;
        ret = ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
        if (ret < 0)
                perror("ERROR: MSHAREFS_CREATE_MAPPING");

        addr = mmap((void *)start, size, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        strncpy(addr, "Some random shared text",
                        sizeof("Some random shared text"));
-----------------


Snippet of code that a consumer process would execute looks like:

-----------------
        struct mshare_info minfo;

        fd = open("/sys/fs/mshare/shareme", O_RDONLY);

        ret = ioctl(fd, MSHAREFS_GET_SIZE, &minfo);
        if (ret < 0)
                perror("ERROR: MSHAREFS_GET_SIZE");
        if (!minfo.start)
                perror("ERROR: mshare region not init'd");

        addr = mmap(minfo.start, minfo.size, PROT_READ | PROT_WRITE,
                        MAP_SHARED, fd, 0);

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
        printf("\nDone\n");

-----------------


v3 -> v2:
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


v1 -> v2:
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


Anthony Yznaga (3):
  mm/mshare: allocate an mm_struct for msharefs files
  mm: create __do_mmap() to take an mm_struct * arg
  mshare: add MSHAREFS_CREATE_MAPPING

Khalid Aziz (7):
  mm: Add msharefs filesystem
  mm/mshare: pre-populate msharefs with information file
  mm/mshare: make msharefs writable and support directories
  mm/mshare: Add ioctl support
  mm/mshare: Add vm flag for shared PTEs
  mm/mshare: Add mmap support
  mm/mshare: Add basic page table sharing support

 Documentation/filesystems/msharefs.rst        | 107 ++++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 include/linux/mm.h                            |  25 +-
 include/trace/events/mmflags.h                |   3 +
 include/uapi/linux/magic.h                    |   1 +
 include/uapi/linux/msharefs.h                 |  38 ++
 mm/Makefile                                   |   2 +-
 mm/internal.h                                 |   6 +
 mm/memory.c                                   |  62 +-
 mm/mmap.c                                     |  12 +-
 mm/mshare.c                                   | 582 ++++++++++++++++++
 11 files changed, 827 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 include/uapi/linux/msharefs.h
 create mode 100644 mm/mshare.c

-- 
2.43.5


