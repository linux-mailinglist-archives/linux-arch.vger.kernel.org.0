Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C17087C9
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjERS3i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjERS3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 14:29:37 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC741B7;
        Thu, 18 May 2023 11:29:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0CE0D320031A;
        Thu, 18 May 2023 14:29:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 18 May 2023 14:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684434571; x=1684520971; bh=tH
        tWwVdk+T3dfEapGxc09loZU1s63o4Dx8wsL+VztSg=; b=tWPlNA2ekwKyDYeufo
        88t/4k8oWwc451jqi6PVY+/gL7cxmTUih0drBDwQjypo979vXHqZjBFKVqdlIBan
        p6S1lCYBAsJd6tUgkoqU3scgNgQsEl4XDiVrn7HYDuDFG8DstU3DkSSPk8DqXx8E
        1PBjReF25/9i3PjC1Fe1Eso3Guj6+hrlGlez3dMx1CCjxM+5AuEb+S7sP16jnJFb
        mRf+EipDj4IysuJOW3mr9VZdotOrGIfJZ1H2MbHhFOBhqQp+HW2MdcF13odCajlt
        NCOqWSGB1HK8MKhHH7pLpC9SD/kAbENikCrNacUgGcn9DQ9nc3cnQccYgwNXfkUC
        IrmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684434571; x=1684520971; bh=tHtWwVdk+T3df
        EapGxc09loZU1s63o4Dx8wsL+VztSg=; b=pWkTsO6vYdAYAWQsR9L4hxpX4HFbD
        HfwUQSLtbhnVIHAyhlTaygSR3cFUF8k+Y+52iuvHv2g2zJMxABQg6hAwvJSpbkPn
        f0Gt0bPuDAjCBEXyOUQ94Td4ujPQ4FdnGhB686kduwQIx6plLpSQeEFQCUmfzMV0
        tRaH6Qc/G6MPwl3qbmCHYQyE+aY0EKsNwWYLqQaozIfdTJtEgCUat0VkDv2I4wWq
        Gn/KLQ9gSIiP4cf2e8oFiFgF3sU7UyBpqJkLgH9VJk3m5ZgbctSEpK1lWAV2XFZP
        iaPgCpxNYJggFF52emxRqztKW/jGBqmFHYU+Eoa9lq11FlR4wH230pujQ==
X-ME-Sender: <xms:iW5mZHpfJqiABPUXVcci3BmPSGF9BabgIQFdEO_5PuQg2XS8cj8Iiw>
    <xme:iW5mZBpfjCryiLtqhG9gcAtYurgTIJBQcenzL9uFaetOauJBbtXUkJ25hjr5OuiJ4
    vdJyswW6J5vPC4bM4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:iW5mZEMyjmpWw_wwGxSMEH5cmS-p6Sensm0cWcWBZRz5fj1g2gPgrQ>
    <xmx:iW5mZK4EW9TJnP9rL3KDENV5pFNZIZG4JrSObBt-kSn1DoMtGUKVXg>
    <xmx:iW5mZG4WoaFSSice931Jxp8ZLHMnLGO3dDzeY2qIXUdxZ3uaJ4ZpZQ>
    <xmx:i25mZLadIciyHLTS_bb7KHjhBTrRxsz-qubajev4SYPQQ28elznzuQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6AA6CB60086; Thu, 18 May 2023 14:29:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <556bebad-3150-4fd5-8725-e4973fd6edd1@app.fastmail.com>
In-Reply-To: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
References: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
Date:   Thu, 18 May 2023 20:29:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@rivosinc.com>, guoren <guoren@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
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
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 18, 2023, at 17:38, Palmer Dabbelt wrote:
> On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> This patch series adds s64ilp32 support to riscv. The term s64ilp32
>> means smode-xlen=64 and -mabi=ilp32 (ints, longs, and pointers are all
>> 32-bit), i.e., running 32-bit Linux kernel on pure 64-bit supervisor
>> mode. There have been many 64ilp32 abis existing, such as mips-n32 [1],
>> arm-aarch64ilp32 [2], and x86-x32 [3], but they are all about userspace.
>> Thus, this should be the first time running a 32-bit Linux kernel with
>> the 64ilp32 ABI at supervisor mode (If not, correct me).
>
> Does anyone actually want this?  At a bare minimum we'd need to add it 
> to the psABI, which would presumably also be required on the compiler 
> side of things.
>
> It's not even clear anyone wants rv64/ilp32 in userspace, the kernel 
> seems like it'd be even less widely used.

We have had long discussions about supporting ilp32 userspace on
arm64, and I think almost everyone is glad we never merged it into
the mainline kernel, so we don't have to worry about supporting it
in the future. The cost of supporting an extra user space ABI
is huge, and I'm sure you don't want to go there. The other two
cited examples (mips-n32 and x86-x32) are pretty much unused now
as well, but still have a maintenance burden until they can finally
get removed.

If for some crazy reason you'd still want the 64ilp32 ABI in user
space, running the kernel this way is probably still a bad idea,
but that one is less clear. There is clearly a small memory
penalty of running a 64-bit kernel for larger data structures
(page, inode, task_struct, ...) and vmlinux, and there is no
huge additional maintenance cost on top of the ABI itself
that you'd need either way, but using a 64-bit address space
in the kernel has some important advantages even when running
32-bit userland: processes can use the entire 4GB virtual
space, while the kernel can address more than 768MB of lowmem,
and KASLR has more bits to work with for randomization. On
RISCV, some additional features (VMAP_STACK, KASAN, KFENCE,
...) depend on 64-bit kernels even though they don't
strictly need that.

     Arnd
