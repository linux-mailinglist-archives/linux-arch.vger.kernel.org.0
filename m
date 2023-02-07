Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8596268CD13
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 04:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBGDFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 22:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjBGDFh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 22:05:37 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BD42713;
        Mon,  6 Feb 2023 19:05:35 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CAC65C016D;
        Mon,  6 Feb 2023 22:05:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 Feb 2023 22:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675739132; x=1675825532; bh=uM1UO9XIp7afVPZ81JNU3mTA9pU3
        uATOl+OKWoLABwo=; b=Zvtnw6gYgKCDuKEV2RFjFXJ5FBEXx07IhXfjRWlutWgR
        kjoYsCYUtD8bMFQQMAAPJ2PIuVbxVk9d4k/iYLeW8dQCYuYY9zxLNpq7URI76DVN
        rpNHp7s/osPWxMn3MWcB7ym0eYCbDN799o3/RKPPOCSzgmB3ToaFWW2UYofXExSR
        ndLAbYsjuLgaDHe1HNYgdRDo2VTpGWOUggV0alEIU5VjiP5y2HASQQpVxnotAaeo
        b5l8Viq7MpHXVTc+9ht6pxDiGKJyqsoCmj/Ua+t8X0zOn1jXnJYp+ylss0EAvm8Z
        HFV+UrB2YeMZjWLZg5TiN/2P6Snn6Xu6d+I0ykKSrQ==
X-ME-Sender: <xms:-7_hY0yLaEiT5vxTUdBxDl-vvGPLAP1mE_FFygN7UrQe0D5vgzifpQ>
    <xme:-7_hY4Szr1ub8i-OhfgaEdSV_aXmPpYC_CVWy-QN0DPNVtmcbkvEP05P-yBKHRg01
    yUQYrm2yh5xejc7o3Y>
X-ME-Received: <xmr:-7_hY2VfKNJGhBNKvlaq-mkjmucCCUtWwnT1e0a-uzfXOdof5jwQa6sL81qclAEq8FxRQtBmDm6yKZt3Zeec1AtYAhre6s4F3Zo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegjedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdek
    vedvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgh
X-ME-Proxy: <xmx:-7_hYyjI5Iz3INyBJhpCTT5TJZ5eguGUSw4EWj-E50vQaXUmRg-j4A>
    <xmx:-7_hY2DtYPpZ6GepDE2Z3WOUI8UqbtKGsjK77kkGMM3eTVpQJUF72Q>
    <xmx:-7_hYzLu70VewWrME5ni_dMDJUopI-i1X5tWdo4D7e4nFjjgyeToxg>
    <xmx:_L_hY66XXXQfZtOPGo4LQ-zlSJhsj6TcgDuPub_gnxS18hq1XxileQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 22:05:28 -0500 (EST)
Date:   Tue, 7 Feb 2023 14:07:03 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
In-Reply-To: <CAHk-=wirpn8qX5hCyeS0a4GCQH5p-2ACXgzJTj7zjZ5rGux_Bw@mail.gmail.com>
Message-ID: <fc3d0151-30a0-c029-3e43-68664d4d50e6@linux-m68k.org>
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0aBPUEpf1bci9@ZenIV> <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org> <CAHk-=wirpn8qX5hCyeS0a4GCQH5p-2ACXgzJTj7zjZ5rGux_Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 5 Feb 2023, Linus Torvalds wrote:

> On Sat, Feb 4, 2023 at 10:16 PM Finn Thain <fthain@linux-m68k.org> wrote:
> >
> > That could be a bug I was chasing back in 2021 but never found. The mmap
> > stressors in stress-ng were triggering a crash on a Mac Quadras, though
> > only rarely. Sometimes it would run all day without a failure.
> >
> > Last year when I started using GCC 12 to build the kernel, I saw the same
> > workload fail again but the failure mode had become a silent hang/livelock
> > instead of the oopses I got with GCC 6.
> >
> > When I press the NMI button after the livelock I always see
> > do_page_fault() in the backtrace. So I've been testing your patch. I've
> > been running the same stress-ng reproducer for about 12 hours now with no
> > failures which looks promising.
> >
> > In case that stress-ng testing is of use:
> > Tested-by: Finn Thain <fthain@linux-m68k.org>
> 
> Could you test the thing that Mark Rutland pointed to? He had an
> actual test-case for this for the arm64 fixes some years ago.
> 
> See
> 
>    https://lore.kernel.org/all/Y9pD+TMP+%2FSyfeJm@FVFF77S0Q05N/
> 
> for his email with links to his old test-case?
> 

With qemu-system-m68k v7.2 runing Linux v6.1, killing Mark's program did 
not trigger any failure.

With my Quadra 650 running the same binaries, killing Mark's program 
produces the BUG splat below. I can confirm that Al's patch fixes it.

[  199.060000] BUG: scheduling while atomic: test/48/0x0003e2e6
[  199.060000] Modules linked in:
[  199.060000] CPU: 0 PID: 48 Comm: test Tainted: G        W          6.1.0-mac #3
[  199.060000] Stack from 00a6204c:
[  199.060000]         00a6204c 004c1979 004c1979 00000000 00a6215e 00a6206c 00408d62 004c1979
[  199.060000]         00a62074 0003ad4a 00a620a8 004099e2 00983480 00000000 00a6215e 00000000
[  199.060000]         00000002 00983480 00a62000 0040970a 00a6209c 00a6209c 00a620c0 00a620c0
[  199.060000]         00409b94 00000000 00bcf0c0 00a62198 00a357fc 00a6216c 00120e5c 00bcf0d0
[  199.060000]         00000003 00000001 00000001 0123f039 00000000 00a357fc 00aead38 005870dc
[  199.060000]         005870dc 00a31200 00000000 00000000 00000000 00010000 0000c000 00000000
[  199.060000] Call Trace: [<00408d62>] dump_stack+0x10/0x16
[  199.060000]  [<0003ad4a>] __schedule_bug+0x5e/0x70
[  199.060000]  [<004099e2>] __schedule+0x2d8/0x446
[  199.060000]  [<0040970a>] __schedule+0x0/0x446
[  199.060000]  [<00409b94>] schedule+0x44/0x8e
[  199.060000]  [<00120e5c>] handle_userfault+0x298/0x3de
[  199.060000]  [<00010000>] zer_rp2+0x14/0x18
[  199.060000]  [<0000c000>] cu_dmrs+0x0/0x16
[  199.060000]  [<00001200>] kernel_pg_dir+0x200/0x1000
[  199.060000]  [<00010000>] zer_rp2+0x14/0x18
[  199.060000]  [<0000c000>] cu_dmrs+0x0/0x16
[  199.060000]  [<00001200>] kernel_pg_dir+0x200/0x1000
[  199.060000]  [<00010000>] zer_rp2+0x14/0x18
[  199.060000]  [<0000c000>] cu_dmrs+0x0/0x16
[  199.060000]  [<000ab0a0>] handle_mm_fault+0xa34/0xa56
[  199.060000]  [<000c0000>] __alloc_pages_bulk+0x26/0x3f8
[  199.060000]  [<00007056>] do_page_fault+0xd8/0x28a
[  199.060000]  [<00006098>] buserr_c+0x1a6/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<000056fc>] do_040writeback1+0x0/0x1d8
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<000062cc>] buserr_c+0x3da/0x6b0
[  199.060000]  [<00001000>] kernel_pg_dir+0x0/0x1000
[  199.060000]  [<00002ac0>] buserr+0x20/0x28
[  199.060000]  [<00001000>] kernel_pg_dir+0x0/0x1000
[  199.060000]  [<00008001>] mac_irq_disable+0x3b/0x98
[  199.060000]  [<00001000>] kernel_pg_dir+0x0/0x1000
[  199.060000]  [<00008001>] mac_irq_disable+0x3b/0x98
[  199.060000] 
