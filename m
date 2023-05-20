Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4063270A4A8
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjETCx6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 22:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjETCx5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 22:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE8C4;
        Fri, 19 May 2023 19:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E604564A20;
        Sat, 20 May 2023 02:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB21C433A0;
        Sat, 20 May 2023 02:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684551233;
        bh=+tGsC/f/TtEfWK/9bFDkg5b1KfVWxm7nqsEyW9s7jC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FarLXZ4vf0PaGXbfTqzHe2HxyH/ai2VncPuTcEQYcIqujvcnZ56XzMlQKZLiqIQcr
         BiDsTjSRMF2EuP+eiPZa71uWeWIxI+W3wqMxOkvpm6jvmCP9ytvri9vtO2NJRUT/fH
         Im9Jw9RcnSajWb696C6DI7vswx5D/G3QBkh5EFuQgr80xBpCetWGh7Kx2DLpVbiRcv
         ThB9PQ7MDd+wGdBI1aqB2Yu+TRjdJLimHXM3gbBqiyNB3f8gw0LrCuO9vCKqdCJAK7
         Z7xg/xDqy3XUQ7Aj3LFguynL9w8phj6uPbOzi6TU/47wgY71ieVEgu9NLpJVvNIzdC
         lqM9PwkyyvDgQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-965c3f9af2aso593793166b.0;
        Fri, 19 May 2023 19:53:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDyv0zAfgyBzVC95PkHfh40CgM8ISRlYKDAzMjrsk9NfU9yAMq4a
        IyJrWxpHUr/ltCAS3ydLvLB/4hqfYDEgzW5Pcs4=
X-Google-Smtp-Source: ACHHUZ7WF3mVA8lYIxFpQ5u5iStM7BEIgJdRnRaVbCmISPZYfrJcSEeoazp4zCW7LShUjUAlu9ghhPxcG3D07w+tFCY=
X-Received: by 2002:a17:907:9450:b0:94e:cf72:8147 with SMTP id
 dl16-20020a170907945000b0094ecf728147mr3855287ejc.48.1684551231150; Fri, 19
 May 2023 19:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230518131013.3366406-1-guoren@kernel.org> <b3689d7f-1a78-46ea-8e1f-48bc080ce993@app.fastmail.com>
In-Reply-To: <b3689d7f-1a78-46ea-8e1f-48bc080ce993@app.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 20 May 2023 10:53:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTStDHmTTZCqWuVNzjyr9A=RWRSMupW-uuBUqnVjx7zgUA@mail.gmail.com>
Message-ID: <CAJF2gTStDHmTTZCqWuVNzjyr9A=RWRSMupW-uuBUqnVjx7zgUA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on
 64-bit supervisor mode
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Anup Patel <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        Andy Chiu <andy.chiu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 20, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, May 18, 2023, at 15:09, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > Why 32-bit Linux?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The motivation for using a 32-bit Linux kernel is to reduce memory
> > footprint and meet the small capacity of DDR & cache requirement
> > (e.g., 64/128MB SIP SoC).
> >
> > Here are the 32-bit v.s. 64-bit Linux kernel data type comparison
> > summary:
> >                       32-bit          64-bit
> > sizeof(page):         32bytes         64bytes
> > sizeof(list_head):    8bytes          16bytes
> > sizeof(hlist_head):   8bytes          16bytes
> > sizeof(vm_area):      68bytes         136bytes
> > ...
>
> > Mem-usage:
> > (s32ilp32) # free
> >        total   used   free  shared  buff/cache   available
> > Mem:  100040   8380  88244      44        3416       88080
> >
> > (s64lp64)  # free
> >        total   used   free  shared  buff/cache   available
> > Mem:   91568  11848  75796      44        3924       75952
> >
> > (s64ilp32) # free
> >        total   used   free  shared  buff/cache   available
> > Mem:  101952   8528  90004      44        3420       89816
> >                      ^^^^^
> >
> > It's a rough measurement based on the current default config without an=
y
> > modification, and 32-bit (s32ilp32, s64ilp32) saved more than 16% memor=
y
> > to 64-bit (s64lp64). But s32ilp32 & s64ilp32 have a similar memory
> > footprint (about 0.33% difference), meaning s64ilp32 has a big chance t=
o
> > replace s32ilp32 on the 64-bit machine.
>
> I've tried to run the same numbers for the debate about running
> 32-bit vs 64-bit arm kernels in the past, but focused mostly on
> slightly larger systems, but I looked mainly at the 512MB case,
> as that is the most cost-efficient DDR3 memory configuration
> and fairly common.
512MB is extravagant, in my opinion. In the IPC market, 32/64MB is for
480P/720P/1080p, 128/256MB is for 1080p/2k, and 512/1024MB is for 4K.
> 512MB chips is less than 5% of the total (I guess). Even in 512MB
chips, the additional memory is for the frame buffer, not the Linux
system.
I agree for the > 512MB scenarios would make it less sensitive on a
32/64-bit Linux kernel.

>
> What I'd like to understand better in your example is where
> the 14MB of memory went. I assume this is for 128MB of total
> RAM, so we know that 1MB went into additional 'struct page'
> objects (32 bytes * 32768 pages). It would be good to know
> where the dynamic allocations went and if they are  reclaimable
> (e.g. inodes) or non-reclaimable (e.g. kmalloc-128).
>
> For the vmlinux size, is this already a minimal config
> that one would run on a board with 128MB of RAM, or a
> defconfig that includes a lot of stuff that is only relevant
> for other platforms but also grows on 64-bit?
It's not minimal config, it's defconfig. So I say it's a roungh measurement=
 :)

I admit I wanted a little bit to exaggerate it, but that's the
starting point for cutting down memory usage for most people, right?
During the past year, we have been convincing our customers to use the
s64lp64 + u32ilp32, but they can't tolerate even 1% memory additional
cost in 64MB/128MB scenarios and then chose cortex-a7/a35, which could
run 32-bit Linux. I think it's too early to talk about throwing 32-bit
Linux into the garbage, not only for the reason of memory footprint
but also for the ingrained opinion of the people. Changing their mind
needs a long time.

>
> What do you see in /proc/slabinfo, /proc/meminfo/, and
> 'size vmlinux' for the s64ilp32 and s64lp64 kernels here?
Both s64ilp32 & s64lp64 use the same u32ilp32_rootfs.ext2 binary and
the same opensbi binary.
All are opensbi(2MB) + Linux(126MB) memory layout.

Here is the result:

s64ilp32:
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0x9ce00000 - 0x9d000000   (2048 kB)
[    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
[    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
[    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
[    0.000000]       lowmem : 0xc0000000 - 0xc7e00000   ( 126 MB)
[    0.000000] Memory: 97748K/129024K available (8699K kernel code,
8867K rwdata, 4096K rodata, 4204K init, 361K bss, 31276K reserved, 0K
cma-reserved)
...
# free
              total        used        free      shared  buff/cache   avail=
able
Mem:         101952        8516       90016          44        3420       8=
9828
Swap:             0           0           0
# cat /proc/meminfo
MemTotal:         101952 kB
MemFree:           90016 kB
MemAvailable:      89836 kB
Buffers:             292 kB
Cached:             2484 kB
SwapCached:            0 kB
Active:             2556 kB
Inactive:            656 kB
Active(anon):         40 kB
Inactive(anon):      440 kB
Active(file):       2516 kB
Inactive(file):      216 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                32 kB
Writeback:             0 kB
AnonPages:           480 kB
Mapped:             1804 kB
Shmem:                44 kB
KReclaimable:        644 kB
Slab:               4536 kB
SReclaimable:        644 kB
SUnreclaim:         3892 kB
KernelStack:         344 kB
PageTables:          112 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       50976 kB
Committed_AS:       2040 kB
VmallocTotal:     524288 kB
VmallocUsed:         112 kB
VmallocChunk:          0 kB
Percpu:               64 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB

# cat /proc/slabinfo

                                                             [68/1691]
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
ext4_groupinfo_1k     28     28    144   28    1 : tunables    0    0
  0 : slabdata      1      1      0
p9_req_t               0      0    104   39    1 : tunables    0    0
  0 : slabdata      0      0      0
UDPv6                  0      0   1088   15    4 : tunables    0    0
  0 : slabdata      0      0      0
tw_sock_TCPv6          0      0    200   20    1 : tunables    0    0
  0 : slabdata      0      0      0
request_sock_TCPv6      0      0    240   17    1 : tunables    0    0
   0 : slabdata      0      0      0
TCPv6                  0      0   2048    8    4 : tunables    0    0
  0 : slabdata      0      0      0
bio-72                32     32    128   32    1 : tunables    0    0
  0 : slabdata      1      1      0
bfq_io_cq              0      0   1000    8    2 : tunables    0    0
  0 : slabdata      0      0      0
bio-184               21     21    192   21    1 : tunables    0    0
  0 : slabdata      1      1      0
mqueue_inode_cache     10     10    768   10    2 : tunables    0    0
   0 : slabdata      1      1      0
v9fs_inode_cache       0      0    576   14    2 : tunables    0    0
  0 : slabdata      0      0      0
nfs4_xattr_cache_cache      0      0   1848   17    8 : tunables    0
  0    0 : slabdata      0      0      0
nfs_direct_cache       0      0    152   26    1 : tunables    0    0
  0 : slabdata      0      0      0
nfs_read_data         36     36    640   12    2 : tunables    0    0
  0 : slabdata      3      3      0
nfs_inode_cache        0      0    832   19    4 : tunables    0    0
  0 : slabdata      0      0      0
isofs_inode_cache      0      0    528   15    2 : tunables    0    0
  0 : slabdata      0      0      0
fat_inode_cache        0      0    632   25    4 : tunables    0    0
  0 : slabdata      0      0      0
fat_cache              0      0     24  170    1 : tunables    0    0
  0 : slabdata      0      0      0
jbd2_journal_handle      0      0     48   85    1 : tunables    0
0    0 : slabdata      0      0      0
jbd2_journal_head      0      0     80   51    1 : tunables    0    0
  0 : slabdata      0      0      0
ext4_fc_dentry_update      0      0     88   46    1 : tunables    0
 0    0 : slabdata      0      0      0
ext4_inode_cache      88     88    984    8    2 : tunables    0    0
  0 : slabdata     11     11      0
ext4_allocation_context     36     36    112   36    1 : tunables    0
   0    0 : slabdata      1      1      0
ext4_io_end_vec        0      0     24  170    1 : tunables    0    0
  0 : slabdata      0      0      0
pending_reservation      0      0     16  256    1 : tunables    0
0    0 : slabdata      0      0      0
extent_status        256    256     32  128    1 : tunables    0    0
  0 : slabdata      2      2      0
mbcache              102    102     40  102    1 : tunables    0    0
  0 : slabdata      1      1      0
dio                    0      0    384   10    1 : tunables    0    0
  0 : slabdata      0      0      0
audit_tree_mark        0      0     64   64    1 : tunables    0    0
  0 : slabdata      0      0      0
rpc_inode_cache        0      0    576   14    2 : tunables    0    0
  0 : slabdata      0      0      0
ip4-frags              0      0    152   26    1 : tunables    0    0
  0 : slabdata      0      0      0
RAW                    9      9    896    9    2 : tunables    0    0
  0 : slabdata      1      1      0
UDP                    8      8    960    8    2 : tunables    0    0
  0 : slabdata      1      1      0
tw_sock_TCP            0      0    200   20    1 : tunables    0    0
  0 : slabdata      0      0      0
request_sock_TCP       0      0    240   17    1 : tunables    0    0
  0 : slabdata      0      0      0
TCP                    0      0   1920    8    4 : tunables    0    0
  0 : slabdata      0      0      0
hugetlbfs_inode_cache      8      8    504    8    1 : tunables    0
 0    0 : slabdata      1      1      0
bio-164               42     42    192   21    1 : tunables    0    0
  0 : slabdata      2      2      0
ep_head                0      0      8  512    1 : tunables    0    0
  0 : slabdata      0      0      0
dax_cache             14     14    576   14    2 : tunables    0    0
  0 : slabdata      1      1      0
sgpool-128            16     16   2048    8    4 : tunables    0    0
  0 : slabdata      2      2      0
sgpool-64              8      8   1024    8    2 : tunables    0    0
  0 : slabdata      1      1      0
request_queue         13     13    616   13    2 : tunables    0    0
  0 : slabdata      1      1      0
blkdev_ioc             0      0     80   51    1 : tunables    0    0
  0 : slabdata      0      0      0
bio-120               64     64    128   32    1 : tunables    0    0
  0 : slabdata      2      2      0
biovec-max            40     40   3072   10    8 : tunables    0    0
  0 : slabdata      4      4      0
biovec-128             0      0   1536   10    4 : tunables    0    0
  0 : slabdata      0      0      0
                                                             [19/1691]
biovec-64             10     10    768   10    2 : tunables    0    0
  0 : slabdata      1      1      0
dmaengine-unmap-2    128    128     32  128    1 : tunables    0    0
  0 : slabdata      1      1      0
sock_inode_cache      22     22    704   11    2 : tunables    0    0
  0 : slabdata      2      2      0
skbuff_small_head     14     14    576   14    2 : tunables    0    0
  0 : slabdata      1      1      0
skbuff_fclone_cache      0      0    448    9    1 : tunables    0
0    0 : slabdata      0      0      0
file_lock_cache       28     28    144   28    1 : tunables    0    0
  0 : slabdata      1      1      0
buffer_head          357    357     80   51    1 : tunables    0    0
  0 : slabdata      7      7      0
proc_dir_entry       256    256    128   32    1 : tunables    0    0
  0 : slabdata      8      8      0
pde_opener             0      0     24  170    1 : tunables    0    0
  0 : slabdata      0      0      0
proc_inode_cache      60     60    536   15    2 : tunables    0    0
  0 : slabdata      4      4      0
seq_file              42     42     96   42    1 : tunables    0    0
  0 : slabdata      1      1      0
sigqueue              85     85     48   85    1 : tunables    0    0
  0 : slabdata      1      1      0
bdev_cache            14     14   1152   14    4 : tunables    0    0
  0 : slabdata      1      1      0
shmem_inode_cache    637    637    600   13    2 : tunables    0    0
  0 : slabdata     49     49      0
kernfs_node_cache  13938  13938     88   46    1 : tunables    0    0
  0 : slabdata    303    303      0
inode_cache          360    360    496    8    1 : tunables    0    0
  0 : slabdata     45     45      0
dentry              1196   1196    152   26    1 : tunables    0    0
  0 : slabdata     46     46      0
names_cache            8      8   4096    8    8 : tunables    0    0
  0 : slabdata      1      1      0
net_namespace          0      0   2944   11    8 : tunables    0    0
  0 : slabdata      0      0      0
iint_cache             0      0     96   42    1 : tunables    0    0
  0 : slabdata      0      0      0
key_jar              105    105    192   21    1 : tunables    0    0
  0 : slabdata      5      5      0
uts_namespace          0      0    416   19    2 : tunables    0    0
  0 : slabdata      0      0      0
nsproxy              102    102     40  102    1 : tunables    0    0
  0 : slabdata      1      1      0
vm_area_struct       255    255     80   51    1 : tunables    0    0
  0 : slabdata      5      5      0
signal_cache          55     55    704   11    2 : tunables    0    0
  0 : slabdata      5      5      0
sighand_cache         60     60   1088   15    4 : tunables    0    0
  0 : slabdata      4      4      0
anon_vma_chain       384    384     32  128    1 : tunables    0    0
  0 : slabdata      3      3      0
anon_vma             168    168     72   56    1 : tunables    0    0
  0 : slabdata      3      3      0
perf_event             0      0    816   10    2 : tunables    0    0
  0 : slabdata      0      0      0
maple_node            32     32    256   16    1 : tunables    0    0
  0 : slabdata      2      2      0
radix_tree_node      338    338    304   13    1 : tunables    0    0
  0 : slabdata     26     26      0
task_group             8      8    512    8    1 : tunables    0    0
  0 : slabdata      1      1      0
mm_struct             20     20    768   10    2 : tunables    0    0
  0 : slabdata      2      2      0
vmap_area            102    102     40  102    1 : tunables    0    0
  0 : slabdata      1      1      0
page->ptl            256    256     16  256    1 : tunables    0    0
  0 : slabdata      1      1      0
kmalloc-cg-8k          0      0   8192    4    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-cg-4k          8      8   4096    8    8 : tunables    0    0
  0 : slabdata      1      1      0
kmalloc-cg-2k         72     72   2048    8    4 : tunables    0    0
  0 : slabdata      9      9      0
kmalloc-cg-1k         32     32   1024    8    2 : tunables    0    0
  0 : slabdata      4      4      0
kmalloc-cg-512        32     32    512    8    1 : tunables    0    0
  0 : slabdata      4      4      0
kmalloc-cg-256        96     96    256   16    1 : tunables    0    0
  0 : slabdata      6      6      0
kmalloc-cg-192        63     63    192   21    1 : tunables    0    0
  0 : slabdata      3      3      0
kmalloc-cg-128       160    160    128   32    1 : tunables    0    0
  0 : slabdata      5      5      0
kmalloc-cg-64        128    128     64   64    1 : tunables    0    0
  0 : slabdata      2      2      0
kmalloc-rcl-8k         0      0   8192    4    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-4k         0      0   4096    8    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-2k         0      0   2048    8    4 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-1k         0      0   1024    8    2 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-512        0      0    512    8    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-256        0      0    256   16    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-192        0      0    192   21    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-128        0      0    128   32    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-64         0      0     64   64    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-8k            12     12   8192    4    8 : tunables    0    0
  0 : slabdata      3      3      0
kmalloc-4k            16     16   4096    8    8 : tunables    0    0
  0 : slabdata      2      2      0
kmalloc-2k            40     40   2048    8    4 : tunables    0    0
  0 : slabdata      5      5      0
kmalloc-1k            88     88   1024    8    2 : tunables    0    0
  0 : slabdata     11     11      0
kmalloc-512          856    856    512    8    1 : tunables    0    0
  0 : slabdata    107    107      0
kmalloc-256           64     64    256   16    1 : tunables    0    0
  0 : slabdata      4      4      0
kmalloc-192          126    126    192   21    1 : tunables    0    0
  0 : slabdata      6      6      0
kmalloc-128         1056   1056    128   32    1 : tunables    0    0
  0 : slabdata     33     33      0
kmalloc-64          5302   5312     64   64    1 : tunables    0    0
  0 : slabdata     83     83      0
kmem_cache_node      128    128     64   64    1 : tunables    0    0
  0 : slabdata      2      2      0
kmem_cache           128    128    128   32    1 : tunables    0    0
  0 : slabdata      4      4      0

s64lp64:
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xff1bfffffee00000 - 0xff1bffffff000000
 (2048 kB)
[    0.000000]       pci io : 0xff1bffffff000000 - 0xff1c000000000000
 (  16 MB)
[    0.000000]      vmemmap : 0xff1c000000000000 - 0xff20000000000000
 (1024 TB)
[    0.000000]      vmalloc : 0xff20000000000000 - 0xff60000000000000
 (16384 TB)
[    0.000000]      modules : 0xffffffff01579000 - 0xffffffff80000000
 (2026 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff60000008000000
 ( 128 MB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff
 (2047 MB)
[    0.000000] Memory: 89380K/131072K available (8638K kernel code,
4979K rwdata, 4096K rodata, 2191K init, 477K bss, 41692K reserved, 0K
cma-reserved)
...
# free
              total        used        free      shared  buff/cache   avail=
able
Mem:          91568       11472       76264          48        3832       7=
6376
Swap:             0           0           0
# cat /proc/meminfo
MemTotal:          91568 kB
MemFree:           76220 kB
MemAvailable:      76352 kB
Buffers:             292 kB
Cached:             2488 kB
SwapCached:            0 kB
Active:             2560 kB
Inactive:            656 kB
Active(anon):         44 kB
Inactive(anon):      440 kB
Active(file):       2516 kB
Inactive(file):      216 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                16 kB
Writeback:             0 kB
AnonPages:           480 kB
Mapped:             1804 kB
Shmem:                48 kB
KReclaimable:       1092 kB
Slab:               6900 kB
SReclaimable:       1092 kB
SUnreclaim:         5808 kB
KernelStack:         688 kB
PageTables:          120 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       45784 kB
Committed_AS:       2044 kB
VmallocTotal:   17592186044416 kB
VmallocUsed:         904 kB
VmallocChunk:          0 kB
Percpu:               88 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
# cat /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
ext4_groupinfo_1k     19     19    208   19    1 : tunables    0    0
  0 : slabdata      1      1      0
p9_req_t               0      0    176   23    1 : tunables    0    0
  0 : slabdata      0      0      0
ip6-frags              0      0    208   19    1 : tunables    0    0
  0 : slabdata      0      0      0
UDPv6                  0      0   1472   11    4 : tunables    0    0
  0 : slabdata      0      0      0
tw_sock_TCPv6          0      0    264   15    1 : tunables    0    0
  0 : slabdata      0      0      0
request_sock_TCPv6      0      0    312   13    1 : tunables    0    0
   0 : slabdata      0      0      0
TCPv6                  0      0   2560   12    8 : tunables    0    0
  0 : slabdata      0      0      0
bio-96                32     32    128   32    1 : tunables    0    0
  0 : slabdata      1      1      0
bfq_io_cq              0      0   1352   12    4 : tunables    0    0
  0 : slabdata      0      0      0
bfq_queue              0      0    576   14    2 : tunables    0    0
  0 : slabdata      0      0      0
mqueue_inode_cache     14     14   1152   14    4 : tunables    0    0
   0 : slabdata      1      1      0
v9fs_inode_cache       0      0    888    9    2 : tunables    0    0
  0 : slabdata      0      0      0
nfs4_xattr_cache_cache      0      0   3168   10    8 : tunables    0
  0    0 : slabdata      0      0      0
nfs_direct_cache       0      0    264   15    1 : tunables    0    0
  0 : slabdata      0      0      0
nfs_commit_data       11     11    704   11    2 : tunables    0    0
  0 : slabdata      1      1      0
nfs_read_data         36     36    896    9    2 : tunables    0    0
  0 : slabdata      4      4      0
nfs_inode_cache        0      0   1272   25    8 : tunables    0    0
  0 : slabdata      0      0      0
isofs_inode_cache      0      0    824   19    4 : tunables    0    0
  0 : slabdata      0      0      0
fat_inode_cache        0      0    976    8    2 : tunables    0    0
  0 : slabdata      0      0      0
fat_cache              0      0     40  102    1 : tunables    0    0
  0 : slabdata      0      0      0
jbd2_journal_head      0      0    144   28    1 : tunables    0    0
  0 : slabdata      0      0      0
jbd2_revoke_table_s      0      0     16  256    1 : tunables    0
0    0 : slabdata      0      0      0
ext4_fc_dentry_update      0      0     96   42    1 : tunables    0
 0    0 : slabdata      0      0      0
ext4_inode_cache     105    105   1496   21    8 : tunables    0    0
  0 : slabdata      5      5      0
ext4_allocation_context     30     30    136   30    1 : tunables    0
   0    0 : slabdata      1      1      0
ext4_prealloc_space     34     34    120   34    1 : tunables    0
0    0 : slabdata      1      1      0
ext4_system_zone     102    102     40  102    1 : tunables    0    0
  0 : slabdata      1      1      0
ext4_io_end_vec        0      0     32  128    1 : tunables    0    0
  0 : slabdata      0      0      0
bio_post_read_ctx    170    170     48   85    1 : tunables    0    0
  0 : slabdata      2      2      0
pending_reservation      0      0     32  128    1 : tunables    0
0    0 : slabdata      0      0      0
extent_status        102    102     40  102    1 : tunables    0    0
  0 : slabdata      1      1      0
mbcache                0      0     56   73    1 : tunables    0    0
  0 : slabdata      0      0      0
dnotify_struct         0      0     32  128    1 : tunables    0    0
  0 : slabdata      0      0      0
pid_namespace          0      0    160   25    1 : tunables    0    0
  0 : slabdata      0      0      0
posix_timers_cache      0      0    272   15    1 : tunables    0    0
   0 : slabdata      0      0      0
rpc_inode_cache        0      0    832   19    4 : tunables    0    0
  0 : slabdata      0      0      0
UNIX                  12     12   1344   12    4 : tunables    0    0
  0 : slabdata      1      1      0
ip4-frags              0      0    224   18    1 : tunables    0    0
  0 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables    0    0
  0 : slabdata      0      0      0
ip_fib_trie           85     85     48   85    1 : tunables    0    0
  0 : slabdata      1      1      0
ip_fib_alias          73     73     56   73    1 : tunables    0    0
  0 : slabdata      1      1      0
UDP                   12     12   1280   12    4 : tunables    0    0
  0 : slabdata      1      1      0
                                                             [35/1689]
tw_sock_TCP            0      0    264   15    1 : tunables    0    0
  0 : slabdata      0      0      0
request_sock_TCP       0      0    312   13    1 : tunables    0    0
  0 : slabdata      0      0      0
TCP                    0      0   2432   13    8 : tunables    0    0
  0 : slabdata      0      0      0
hugetlbfs_inode_cache     10     10    784   10    2 : tunables    0
 0    0 : slabdata      1      1      0
bio-224               48     48    256   16    1 : tunables    0    0
  0 : slabdata      3      3      0
ep_head                0      0     16  256    1 : tunables    0    0
  0 : slabdata      0      0      0
inotify_inode_mark      0      0     96   42    1 : tunables    0    0
   0 : slabdata      0      0      0
dax_cache              8      8    960    8    2 : tunables    0    0
  0 : slabdata      1      1      0
sgpool-128            10     10   3072   10    8 : tunables    0    0
  0 : slabdata      1      1      0
sgpool-64             10     10   1536   10    4 : tunables    0    0
  0 : slabdata      1      1      0
sgpool-16             10     10    384   10    1 : tunables    0    0
  0 : slabdata      1      1      0
request_queue         15     15   1040   15    4 : tunables    0    0
  0 : slabdata      1      1      0
bio-160               42     42    192   21    1 : tunables    0    0
  0 : slabdata      2      2      0
biovec-128             8      8   2048    8    4 : tunables    0    0
  0 : slabdata      1      1      0
biovec-64              8      8   1024    8    2 : tunables    0    0
  0 : slabdata      1      1      0
user_namespace         0      0    632   25    4 : tunables    0    0
  0 : slabdata      0      0      0
uid_cache             84     84    192   21    1 : tunables    0    0
  0 : slabdata      4      4      0
dmaengine-unmap-2     64     64     64   64    1 : tunables    0    0
  0 : slabdata      1      1      0
sock_inode_cache      24     24   1024    8    2 : tunables    0    0
  0 : slabdata      3      3      0
skbuff_small_head     12     12    640   12    2 : tunables    0    0
  0 : slabdata      1      1      0
skbuff_fclone_cache      0      0    512    8    1 : tunables    0
0    0 : slabdata      0      0      0
file_lock_cache       17     17    232   17    1 : tunables    0    0
  0 : slabdata      1      1      0
fsnotify_mark_connector      0      0     56   73    1 : tunables    0
   0    0 : slabdata      0      0      0
pde_opener             0      0     40  102    1 : tunables    0    0
  0 : slabdata      0      0      0
proc_inode_cache      57     57    848   19    4 : tunables    0    0
  0 : slabdata      3      3      0
seq_file              26     26    152   26    1 : tunables    0    0
  0 : slabdata      1      1      0
sigqueue              51     51     80   51    1 : tunables    0    0
  0 : slabdata      1      1      0
bdev_cache            18     18   1792    9    4 : tunables    0    0
  0 : slabdata      2      2      0
shmem_inode_cache    646    646    936   17    4 : tunables    0    0
  0 : slabdata     38     38      0
kernfs_iattrs_cache      0      0     96   42    1 : tunables    0
0    0 : slabdata      0      0      0
kernfs_node_cache  14304  14304    128   32    1 : tunables    0    0
  0 : slabdata    447    447      0
filp                  84     84    320   12    1 : tunables    0    0
  0 : slabdata      7      7      0
inode_cache          360    360    776   10    2 : tunables    0    0
  0 : slabdata     36     36      0
dentry              1188   1188    216   18    1 : tunables    0    0
  0 : slabdata     66     66      0
names_cache           48     48   4096    8    8 : tunables    0    0
  0 : slabdata      6      6      0
net_namespace          0      0   3840    8    8 : tunables    0    0
  0 : slabdata      0      0      0
iint_cache             0      0    152   26    1 : tunables    0    0
  0 : slabdata      0      0      0
uts_namespace          0      0    432    9    1 : tunables    0    0
  0 : slabdata      0      0      0
nsproxy               56     56     72   56    1 : tunables    0    0
  0 : slabdata      1      1      0
vm_area_struct       240    240    136   30    1 : tunables    0    0
  0 : slabdata      8      8      0
files_cache           22     22    704   11    2 : tunables    0    0
  0 : slabdata      2      2      0
signal_cache          56     56   1152   14    4 : tunables    0    0
  0 : slabdata      4      4      0
sighand_cache         57     57   1664   19    8 : tunables    0    0
  0 : slabdata      3      3      0
task_struct           55     55   2880   11    8 : tunables    0    0
  0 : slabdata      5      5      0
anon_vma             120    120    136   30    1 : tunables    0    0
  0 : slabdata      4      4      0
perf_event             0      0   1152   14    4 : tunables    0    0
  0 : slabdata      0      0      0
maple_node           304    304    256   16    1 : tunables    0    0
  0 : slabdata     19     19      0
radix_tree_node      350    350    584   14    2 : tunables    0    0
  0 : slabdata     25     25      0
task_group            10     10    768   10    2 : tunables    0    0
  0 : slabdata      1      1      0
mm_struct             22     22   1408   11    4 : tunables    0    0
  0 : slabdata      2      2      0
vmap_area            168    168     72   56    1 : tunables    0    0
  0 : slabdata      3      3      0
page->ptl            170    170     24  170    1 : tunables    0    0
  0 : slabdata      1      1      0
kmalloc-cg-8k          0      0   8192    4    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-cg-4k         24     24   4096    8    8 : tunables    0    0
  0 : slabdata      3      3      0
kmalloc-cg-2k         32     32   2048    8    4 : tunables    0    0
  0 : slabdata      4      4      0
kmalloc-cg-1k         24     24   1024    8    2 : tunables    0    0
  0 : slabdata      3      3      0
kmalloc-cg-512        32     32    512    8    1 : tunables    0    0
  0 : slabdata      4      4      0
kmalloc-cg-256        16     16    256   16    1 : tunables    0    0
  0 : slabdata      1      1      0
kmalloc-cg-192       147    147    192   21    1 : tunables    0    0
  0 : slabdata      7      7      0
kmalloc-cg-128        64     64    128   32    1 : tunables    0    0
  0 : slabdata      2      2      0
kmalloc-cg-64        320    320     64   64    1 : tunables    0    0
  0 : slabdata      5      5      0
kmalloc-rcl-8k         0      0   8192    4    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-4k         0      0   4096    8    8 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-2k         0      0   2048    8    4 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-1k         0      0   1024    8    2 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-512        0      0    512    8    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-256        0      0    256   16    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-192        0      0    192   21    1 : tunables    0    0
  0 : slabdata      0      0      0
kmalloc-rcl-128      320    320    128   32    1 : tunables    0    0
  0 : slabdata     10     10      0
kmalloc-rcl-64        64     64     64   64    1 : tunables    0    0
  0 : slabdata      1      1      0
kmalloc-8k            12     12   8192    4    8 : tunables    0    0
  0 : slabdata      3      3      0
kmalloc-4k            16     16   4096    8    8 : tunables    0    0
  0 : slabdata      2      2      0
kmalloc-2k            64     64   2048    8    4 : tunables    0    0
  0 : slabdata      8      8      0
kmalloc-1k           840    840   1024    8    2 : tunables    0    0
  0 : slabdata    105    105      0
kmalloc-512          144    144    512    8    1 : tunables    0    0
  0 : slabdata     18     18      0
kmalloc-256          816    816    256   16    1 : tunables    0    0
  0 : slabdata     51     51      0
kmalloc-192          252    252    192   21    1 : tunables    0    0
  0 : slabdata     12     12      0
kmalloc-128          480    480    128   32    1 : tunables    0    0
  0 : slabdata     15     15      0
kmalloc-64          4912   4928     64   64    1 : tunables    0    0
  0 : slabdata     77     77      0
kmem_cache_node      128    128    128   32    1 : tunables    0    0
  0 : slabdata      4      4      0
kmem_cache           126    126    192   21    1 : tunables    0    0
  0 : slabdata      6      6      0

>
>        Arnd



--=20
Best Regards
 Guo Ren
