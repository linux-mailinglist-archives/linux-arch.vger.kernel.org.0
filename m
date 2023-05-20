Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E044B70A71D
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjETKOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjETKOC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 06:14:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C73189;
        Sat, 20 May 2023 03:13:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AAB523200928;
        Sat, 20 May 2023 06:13:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 20 May 2023 06:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684577631; x=1684664031; bh=uAnEpHaFF9WbLWTeZT0TO/vrnOle5pcV/U1
        ukt7khWw=; b=AHyhZTIp9AJVZdDyXEQaovqAGz8P66/XL6mEvQ6jdFdNG2Rb8F2
        ukvB2qlG90xSeugs3shhki8hZ7xbYWA6ipkl7R4RmUNVZQDezFGFrwoyT2lanZIW
        DFl1aeeVdGXypMlOO7DniuzYbtm5jCXfiXO5Zau+36mrWvazLPHb09GY4cAAuxVT
        ZN9YncjodIBOQ5XX9r4P/K1q9h1o+IDm+tdnsiidAArf+d5mJ2VeHB/6MLUI4Ix5
        hnGH8uPQZNKzD4PO/2u/Lo4jszsOj5FQRorIPyAODDWB75FQCOmSKNdV+t//O/4J
        /XpF26RfyxucDJPeZAApeCLJIgXeQ2FhLbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684577631; x=1684664031; bh=uAnEpHaFF9WbLWTeZT0TO/vrnOle5pcV/U1
        ukt7khWw=; b=SUTrTFFvsdTLBFSxj/b1Fq2ZVdaB9MXLtFEDfUsb9Rh8NCuFypX
        vidHIZfWp5th3G+3PnI/gb2srq14HOrk7VjKQBz2w9J3Xa2tHh69v3IlsTk7naBs
        w1PhkEXtN/ew3bTp774TiLdr3N3PCapF3k6j6chFfAh9yYZDumRJd5Q77HjlG0LX
        GTWX/B8TWQ9YHRS0oHTP83xaIdOR76B8bxFDC5cI/eghw4HG9fS6g6lEjN8U9+gB
        fqLSZ7H6wu0yQkmEgxRVj0SGgg+SIRsr5ZoAogjRE35eHbupbFZQUL0hcRnLUbjE
        GyLp5bmT8CXT40y5yCjahPW91JW98S+WW4Q==
X-ME-Sender: <xms:XZ1oZBgBZSrHPWsL-O00-TeEPoZi1pOe3XJFJiEUARaxB5LTRqUpLw>
    <xme:XZ1oZGAjE-Ybz2xwk_jLIfpCs_gTBYLS_LWFpNywHGh6Mmf3cCrAKZahm6gphBYzo
    X71K7YBza6I9x-ugjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeijedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffjeeugefhgfeutedvieehheeuteduvdfgtdeivefgtefhveejueeltdel
    feekgfenucffohhmrghinhepsghorghrugdquggsrdhorhhgpdhslhgrsghsrdgtrghtpd
    gvlhhinhhugidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XZ1oZBGozvtOglvbcypYk0exAjAygTgbBAijlbiB3TfXM2QTmEahJw>
    <xmx:XZ1oZGRBjNT-OHcGgwKojCnEZOSn3boi8S62vu9HQeVViGgNZVObBA>
    <xmx:XZ1oZOxz674YIVbzFHeLTnXmFQZ4zoa47anQplwv1ci0UIZBsM_frA>
    <xmx:X51oZPRjPQUbzhaRqxLjLuioB9MVx5kTCjxV3vbH6SeENLl5yrXcxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 533D6B6008D; Sat, 20 May 2023 06:13:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <5a570d3e-21db-44d0-81e3-2829e6aef198@app.fastmail.com>
In-Reply-To: <CAJF2gTStDHmTTZCqWuVNzjyr9A=RWRSMupW-uuBUqnVjx7zgUA@mail.gmail.com>
References: <20230518131013.3366406-1-guoren@kernel.org>
 <b3689d7f-1a78-46ea-8e1f-48bc080ce993@app.fastmail.com>
 <CAJF2gTStDHmTTZCqWuVNzjyr9A=RWRSMupW-uuBUqnVjx7zgUA@mail.gmail.com>
Date:   Sat, 20 May 2023 12:13:27 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
        "Anup Patel" <anup@brainfault.org>, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        "Andy Chiu" <andy.chiu@sifive.com>,
        "Vincent Chen" <vincent.chen@sifive.com>,
        "Greentime Hu" <greentime.hu@sifive.com>,
        "Jonathan Corbet" <corbet@lwn.net>, wuwei2016@iscas.ac.cn,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        "Guo Ren" <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on 64-bit
 supervisor mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 20, 2023, at 04:53, Guo Ren wrote:
> On Sat, May 20, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Thu, May 18, 2023, at 15:09, guoren@kernel.org wrote:
>>
>> I've tried to run the same numbers for the debate about running
>> 32-bit vs 64-bit arm kernels in the past, but focused mostly on
>> slightly larger systems, but I looked mainly at the 512MB case,
>> as that is the most cost-efficient DDR3 memory configuration
>> and fairly common.
> 512MB is extravagant, in my opinion. In the IPC market, 32/64MB is for
> 480P/720P/1080p, 128/256MB is for 1080p/2k, and 512/1024MB is for 4K.
>> 512MB chips is less than 5% of the total (I guess). Even in 512MB
> chips, the additional memory is for the frame buffer, not the Linux
> system.

This depends a lot on the target application of course. For
a phone or NAS box, 512MB is probably the lower limit.

What I observe in arch/arm/ devicetree submissions, in board-db.org,
and when looking at industrial Arm board vendor websites  is that
512MB is the most common configuration, and I think 1GB is still
more common than 256MB even for 32-bit machines. There is of course
a difference between number of individual products, and number of
machines shipped in a given configuration, and I guess you have
a good point that the cheapest ones are also the ones that ship
in the highest volume.

>> What I'd like to understand better in your example is where
>> the 14MB of memory went. I assume this is for 128MB of total
>> RAM, so we know that 1MB went into additional 'struct page'
>> objects (32 bytes * 32768 pages). It would be good to know
>> where the dynamic allocations went and if they are  reclaimable
>> (e.g. inodes) or non-reclaimable (e.g. kmalloc-128).
>>
>> For the vmlinux size, is this already a minimal config
>> that one would run on a board with 128MB of RAM, or a
>> defconfig that includes a lot of stuff that is only relevant
>> for other platforms but also grows on 64-bit?
> It's not minimal config, it's defconfig. So I say it's a roungh
> measurement :)
>
> I admit I wanted a little bit to exaggerate it, but that's the
> starting point for cutting down memory usage for most people, right?
> During the past year, we have been convincing our customers to use the
> s64lp64 + u32ilp32, but they can't tolerate even 1% memory additional
> cost in 64MB/128MB scenarios and then chose cortex-a7/a35, which could
> run 32-bit Linux. I think it's too early to talk about throwing 32-bit
> Linux into the garbage, not only for the reason of memory footprint
> but also for the ingrained opinion of the people. Changing their mind
> needs a long time.
>
>>
>> What do you see in /proc/slabinfo, /proc/meminfo/, and
>> 'size vmlinux' for the s64ilp32 and s64lp64 kernels here?
> Both s64ilp32 & s64lp64 use the same u32ilp32_rootfs.ext2 binary and
> the same opensbi binary.
> All are opensbi(2MB) + Linux(126MB) memory layout.
>
> Here is the result:
>
> s64ilp32:
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0x9ce00000 - 0x9d000000   (2048 kB)
> [    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
> [    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
> [    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
> [    0.000000]       lowmem : 0xc0000000 - 0xc7e00000   ( 126 MB)
> [    0.000000] Memory: 97748K/129024K available (8699K kernel code,
> 8867K rwdata, 4096K rodata, 4204K init, 361K bss, 31276K reserved, 0K
> cma-reserved)

Ok, so it saves only a little bit on .text/.init/.bss/.rodata, but
there is a 4MB difference in rwdata, and a total of 10.4MB difference
in "reserved" size, which I think includes all of the above plus
the mem_map[] array.

89380K/131072K available (8638K kernel code, 4979K rwdata, 4096K rodata,=
 2191K init, 477K bss, 41692K reserved, 0K cma-reserved)

Oddly, I don't see anywhere close to 8KB in a riscv64 defconfig
build (linux-next, gcc-13), so I don't know where that comes
from:

$ size -A build/tmp/vmlinux | sort -k2 -nr | head
Total                   13518684
.text                    8896058   18446744071562076160
.rodata                  2219008   18446744071576748032
.data                     933760   18446744071583039488
.bss                      476080   18446744071584092160
.init.text                264718   18446744071572553728
__ksymtab_strings         183986   18446744071579214312
__ksymtab_gpl             122928   18446744071579091384
__ksymtab                 109080   18446744071578982304
__bug_table                98352   18446744071583973248



> KReclaimable:        644 kB
> Slab:               4536 kB
> SReclaimable:        644 kB
> SUnreclaim:         3892 kB
> KernelStack:         344 kB

These look like the only notable differences in meminfo:

  KReclaimable:       1092 kB                                       =20
  Slab:               6900 kB                                       =20
  SReclaimable:       1092 kB                                       =20
  SUnreclaim:         5808 kB                                       =20
  KernelStack:         688 kB                                       =20

The largest chunk here is 2MB in non-reclaimable slab allocations,
or a 50% growth of those.

The kernel stacks are doubled as expected, but that's only 344KB,
similarly for reclaimable slabs.

> # cat /proc/slabinfo
>
>                                                              [68/1691]
> slabinfo - version: 2.1
> # name            <active_objs> <num_objs> <objsize> <objperslab>
> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
> slabdata <active_slabs> <num_slabs> <sharedavail>
> ext4_groupinfo_1k     28     28    144   28    1 : tunables    0    0
>   0 : slabdata      1      1      0
> p9_req_t               0      0    104   39    1 : tunables    0    0

Did you perhaps miss a few lines while pasting these? It seems
odd that some caches only show up in the ilp32 case (proc_dir_entry,
bd2_journa_handle, buffer_head, biovec_max, anon_vma_chain, ...) and
some others are only in the lp64 case (UNIX, ext4_prealloc_space,
files_cache, filp, ip_fib_alias, task_struct, uid_cache, ...).

Looking at the ones that are in both and have the largest size
increase, I see

# lp64
1788 kernfs_node_cache 14304 128
 590 shmem_inode_cache 646 936
 272 inode_cache 360 776
 153 ext4_inode_cache 105 1496
 250 dentry 1188 216
 192 names_cache 48 4096
 199 radix_tree_node 350 584
 307 kmalloc-64 4912 64
  60 kmalloc-128 480 128
  47 kmalloc-192 252 192
 204 kmalloc-256 816 256
  72 kmalloc-512 144 512
 840 kmalloc-1k 840 1024

# ilp32
1197 kernfs_node_cache 13938 88
 373 shmem_inode_cache 637 600
 174 inode_cache 360 496
  84 ext4_inode_cache 88 984
 177 dentry 1196 152
  32 names_cache 8 4096
 100 radix_tree_node 338 304
 331 kmalloc-64 5302 64
 132 kmalloc-128 1056 128
  23 kmalloc-192 126 192
  16 kmalloc-256 64 256
 428 kmalloc-512 856 512
  88 kmalloc-1k 88 1024

So sysfs (kernfs_node_cache) has the largest chunk of the
2MB non-reclaimable slab, grown 50% from 1.2MB to 1.8MB.
In some cases, this could be avoided entirely by turning
off sysfs, but most users can't do that.
shmem_inode_cache is probably mostly devtmpfs, the
other inode caches ones are smaller and likely reclaimable.

It's interesting how the largest slab cache ends up
being the kmalloc-1k cache (840 1K objects) on lp64,
but the kmalloc-512 cache (856 512B objects) on ilp32.
My guess is that the majority of this is from a single
callsite that has an allocation groing just beyond 512B.
This alone seems significant enough to need further
investigation, I would hope we can completely avoid
these by adding a custom slab cache. I don't see this
effect on an arm64 boot though, for me the 512B allocations
are much higher the 1K ones.

Maybe you can identify the culprit using the boot-time traces
as listed in https://elinux.org/Kernel_dynamic_memory_analysis#Dynamic
That might help everyone running a 64-bit kernel on
low-memory configurations, though it would of course slightly
weaken your argument for an ilp32 kernel ;-)

     Arnd
