Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A967004A9
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjELKFl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjELKFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:05:18 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED391160F;
        Fri, 12 May 2023 03:04:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 35DA05803BB;
        Fri, 12 May 2023 06:04:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 May 2023 06:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683885897; x=1683893097; bh=Sy9HnHCUR0wgx
        XvXSub8VPhHbi3glugACk+bWVmVgIc=; b=WhVQmtMRWmrKfxLLyfJfFe1tMkKp7
        g6eq0i3azbYbNCGWf+UMTGhcfp6yhbpptBIs4OqEAtA4vGLMFHBgeMZ94UwEy1/Q
        frKlmEBriuLTrWnQ2Zy4Tp/dXSYwpun1+4Yl9lHF77De6XwTJqxU0pcwSSrriFEw
        yGSrY7ACNFxiIciWY0lnexIltUq/sgF2oTYXOhWeqBkSnJZlOy0hvX+5SdfF5iP4
        lLpBuBDXP58/5HFV2w9nifKxszItYlsFk7aULlJfIJCUzOBdSps4bdVQDparXGg8
        HQRYSsVcF/3WNSaPigWgAJKd+HcUzPk3A8wtldh0Zv9fOY2cXUATQBdzw==
X-ME-Sender: <xms:Rw9eZN4u3iw-extBaYZWahWQIPn2TyHW_-Tr2mANrdjf7MvkMDA4Zw>
    <xme:Rw9eZK6EU7nC4b3LD3PHu-kTmrubf5DuKNExHZZD1mncoiuA0TMips9BZxL_yVjTb
    v4xRqLxBxsAJa__lQ4>
X-ME-Received: <xmr:Rw9eZEcqjB2aT9_uW8KK8InceO94NMww_1B_vB-QKARGge1inQuJyxOwqOjxo5WEY23XzEeXPb5je35qF9lx2nuV_yKH05nwAg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:Rw9eZGI2AVN261Gh5tsyKTOl-BDY9RqG_dZkG6P7jvBKjRMncxs_eQ>
    <xmx:Rw9eZBL4-8ibaIgszFf3DoCpMiQxiYir7_v9MLCz_ETSUaNtIWk4QQ>
    <xmx:Rw9eZPxnp8EZedlf1COCSe4CgtYjyh2lxNRLIn1Hgaj6Fm0hhsA8gw>
    <xmx:SQ9eZJLRHRSCwZK28BFKNsWtPD-yftzvlsnR-XMW0AqnAUxKarRGRA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 06:04:54 -0400 (EDT)
Date:   Fri, 12 May 2023 20:04:48 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
cc:     Helge Deller <deller@gmx.de>, Sui Jingfeng <15330273260@189.cn>,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, arnd@arndb.de, sam@ravnborg.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
In-Reply-To: <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
Message-ID: <7c2a6687-9c4e-efed-5e25-774b582e9a27@linux-m68k.org>
References: <20230510110557.14343-1-tzimmermann@suse.de> <20230510110557.14343-2-tzimmermann@suse.de> <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn> <a2315b9a-0747-1f0f-1f0a-1c6773931db4@suse.de> <15fe1489-f0fa-bbf6-ec08-a270bd4f1559@gmx.de>
 <e7bd021c-1a6b-6e47-143a-36ae2fd2fe6b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 11 May 2023, Thomas Zimmermann wrote:

> But I'd really like to see most of these drivers being moved into 
> staging and deleted soon afterwards. Users will complain about those 
> drivers that are really still required. Those might be worth to spend 
> effort on.
> 

That strategy is not going to find out what functionality is required. 
Instead it will find out which beneficiaries are capable of overcoming all 
of the hurdles to reverting deletion:

 - Find out how to report a regression correctly.
 - Gather all the necessary information.
 - Obtain buy-in from a sympathetic developer.
 - Build a patched kernel, test it and provide the results. (And possibly 
   repeat the same until neglected code becomes accepted.)
 - Wait for the relevant distro to release the relevant kernel update. 

Developers tend to overlook the burden of process because it's ostensibly 
done to raise code quality. But it seems to me that affected users are 
more likely to seek a workaround than undertake the process.

So deletion doesn't discover end-user requirements. What it does is 
advertise a vacancy for an unpaid adoptive maintainer, somehow presumed to 
be found amongst a very well remunerated and very small pool of talent.

The way I look at it, the maintainence of old code is the price of a 
so-called "right to repair". But there ain't no free lunch and if we want 
that right we should seek ways to reduce that price. For example, by 
making a larger talent pool more effective, by re-using more code and by 
improving the tooling and automation.

The code I'd delete first wouldn't be a small amount of old code in need 
of sponsorship. Or even the most buggy code. The first to go would be that 
code which will never find an actual end user because some portion of the 
code required to actually use certain platforms was never mainlined by the 
vendor -- and never will be without some push-back.
