Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D527996CC
	for <lists+linux-arch@lfdr.de>; Sat,  9 Sep 2023 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbjIIIEU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Sep 2023 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjIIIEU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Sep 2023 04:04:20 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61EC19BA;
        Sat,  9 Sep 2023 01:04:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7294A580955;
        Sat,  9 Sep 2023 04:04:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 04:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694246646; x=1694253846; bh=gr
        bdhyMY7NxNdYcqo5ZxM4YzfzXCIZPyhmdZ4v8wTn0=; b=jcFHpGDMxb0ub6SgBG
        +TF2uT3JbRG5rK7IKiNvJ7vlBdLbUKAMBSCr0GRmD1qvnw3wQMrlnaIBMT6HgL21
        tHB1ij192ixeJRmAY9ANCaq2uSmYh+FTJd7g6WBfsgyhXKCnycEHcPtuc54DamkS
        khM9AYRkM3uv8YQxaDaXYNUY/hynnSLC/64GoRk/TUm13+lkHbpP59YpulVlN0cz
        BSxT56PB5cBjXcxOGaTcleYTt6WmFmxUhbOZQVFwwFyMQ7Khvvbx0QnIFsoIrdc6
        3Dp0YVyo3FB5HLQdyB3FzG2MJzn8Awvy0Pa9EIAZNh7VGDmyTvsy877TjVDmxIg6
        rz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694246646; x=1694253846; bh=grbdhyMY7NxNd
        Ycqo5ZxM4YzfzXCIZPyhmdZ4v8wTn0=; b=cLqGc7RBEBP0PFyVbyiffdpqfBR7/
        Mf9n5q14JmhZwNGe/XElC2gBwEf4NMI92dv5MDUDV2/6itANdcO6Pfshj9qw4E8o
        J3pN3XqPmbkNh52ANIX8bxjPKnbzyD8rSPEaDUELnh8ToLQOvfAYekO6H3fr1W/U
        kCQwoklKTjFyzMWgZR1w/gxhePoBQ4VS2o0KxcWZlB464kotNi0cNalYLMdYp4wY
        RByVLM+KEbqHr/G64mpNEooBKfWn2GAxOQ9DOe2OGThkjsMhd5nexzthBMPy5iPS
        wfJgiGPYnHnd8jsYIJg9g3jRnW//fGvoifpsAwfx7jXSUOuvV5xJ/be8w==
X-ME-Sender: <xms:9Sb8ZOalQxWM7d8-I7UGi8hg2iWSVT4byBVp5_hK3jeB48deIGPw_A>
    <xme:9Sb8ZBZj2IBpdwOYyV4JnFpZdQJRYewg5lNr7p3aLcIaW8YzyACdpFbWABZTABwp9
    6dTcnbA2lKm-k5Ai70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9Sb8ZI9M0KhmD1iC5LR5rRA0H4CbiCpBxI3iNB8E-9NlGD_IZJIsqg>
    <xmx:9Sb8ZAp_MOAOWzJY4OYMgRARmPS2r7ktUrNcjPvwZL87_BzPshSLPw>
    <xmx:9Sb8ZJrXRAxuS0ZRhWRZO9yJG7RZ7OT-fZ5lXpYZlSeMhBbA3JKIqA>
    <xmx:9ib8ZHgZQayI_WMLXMdxs6iYBQLI-pHKZTIeG3AOm5O0xYDs0fuk5g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CDBBEB60089; Sat,  9 Sep 2023 04:04:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
In-Reply-To: <20230907075453.350554-4-gregory.price@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
Date:   Sat, 09 Sep 2023 10:03:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, x86@kernel.org,
        "Gregory Price" <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 7, 2023, at 09:54, Gregory Price wrote:
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl 
> b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2d0b1bd866ea..25db6d71af0c 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -457,3 +457,4 @@
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	i386	cachestat		sys_cachestat
>  452	i386	fchmodat2		sys_fchmodat2
> +454	i386	move_phys_pages		sys_move_phys_pages
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl 
> b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1d6eee30eceb..9676f2e7698c 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -375,6 +375,7 @@
>  451	common	cachestat		sys_cachestat
>  452	common	fchmodat2		sys_fchmodat2
>  453	64	map_shadow_stack	sys_map_shadow_stack
> +454	common	move_phys_pages		sys_move_phys_pages

Doing only x86 is fine for review purposes, but note that
once there is consensus on actually merging it and the syscall
number, you should do the same for all architectures. I think
most commonly we do one patch to add the code and another
patch to hook it up to all the syscall.tbl files and the
include/uapi/asm-generic/unistd.h file.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 22bc6bc147f8..6860675a942f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -821,6 +821,11 @@ asmlinkage long sys_move_pages(pid_t pid, unsigned 
> long nr_pages,
>  				const int __user *nodes,
>  				int __user *status,
>  				int flags);
> +asmlinkage long sys_move_phys_pages(unsigned long nr_pages,
> +				    const void __user * __user *pages,
> +				    const int __user *nodes,
> +				    int __user *status,
> +				    int flags);

The prototype looks good from a portability point of view,
i.e. I made sure this is portable across CONFIG_COMPAT
architectures etc.

What I'm not sure about is whether the representation of physical
memory pages as a 'void *' is a good choice, I can see potential
problems with this:

- it's not really a pointer, but instead a shifted PFN number
  in the implementation

- physical addresses may be wider than pointers on 32-bit
  architectures with CONFIG_PHYS_ADDR_T_64BIT

I'm also not sure where the user space caller gets the
physical addresses from, are those not intentionally kept
hidden from userspace?

     Arnd
