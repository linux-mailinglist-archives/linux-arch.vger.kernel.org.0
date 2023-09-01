Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396A78F6D0
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 03:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbjIABqM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 21:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjIABqL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 21:46:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7230BE6E;
        Thu, 31 Aug 2023 18:46:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E29B5C007C;
        Thu, 31 Aug 2023 21:46:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 31 Aug 2023 21:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693532760; x=1693619160; bh=/d
        C0IWBjlOk1cS3fGjjVkXrON0sGSFSdKCiYoOsqrQ0=; b=lov1FblwV5W5dXCW3y
        PyhVhnq8a0HDk2STH0OY515uM4YgLit8RKC+mD4F7jyfHGCKgqpDsj7HOrGzgonS
        RJIMYIS5rdW8g1u4KDce3nmlUJWX/3/Trdj8E+c4+hm8pdu0yemEOslldINe2KdB
        MDT3AMS0+xzBcGael/Q3t6mjl8uXNsXeg06Akf2qONFaDhXcGowEkvhKd+1WQQhZ
        8Av4E57X48mSAUu/XuACqnpalmTajcrvnzn+hudkGgPP2kbgh3RAzsAhtbPyUqSa
        YZ+2+KvrjOvv6zGJULSyuYuLibwJiiNufhd6YXiiiCaMHHlkZWe/ayOofE67Lcrl
        TNeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693532760; x=1693619160; bh=/dC0IWBjlOk1c
        S3fGjjVkXrON0sGSFSdKCiYoOsqrQ0=; b=KNqq/RgJqoO2rbDyJbQroiP9/8Y75
        WalTecsNOJmxB9enurBhjpkyDFqmOmnBfZcA8c1bYAnnZheb8B6wmEI7LXJgcZNf
        O69Wtof8HXrRjU0fANKAtKCK/yxhtHYuY6qBr5YuDj9XY+kR3vonsp0T/1LELLyX
        8gItwmw8Xqi/k9HiKjVi4G+i81a0qd48Ed9N42NGgUThYzNOTAGbut1DnMMsKIJE
        0TKStVwxfSq2VoqD/jVUA7/LpvJSFqf1HSqZ6N511RjAjfKj+2Y8vIKJbc6CJhqA
        mElnFI/nuJCtcWPjZDzRwun1SBjFmcnBldXMl/pSTxHkX4rOHq6ikTY2Q==
X-ME-Sender: <xms:V0LxZOt375m-3W8VOySJrjnjr9ObhvdGxUmMdn04bqErZBhnqNAkIQ>
    <xme:V0LxZDdNTU-ss4sANAeM8AHqiCe-VSw3RHijcQZZG-sP6F-M5Gn8lDenFsgvKXnwP
    uZjvtoszEM_GhndjvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeguddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:V0LxZJyiXQ8Yw6bEIvINotqM1dyr27oQwtGb7O0bxkKU_1Cz34gKPQ>
    <xmx:V0LxZJPQqR-wEf4eK6SJLtq6RvhCnuEyv9Rdmqn4M8yvLGIf6HG7Lg>
    <xmx:V0LxZO-keQqiLYWIaNv0YxcGr1Xh2g8vSrHDvNxCaGYfOshb7-coCQ>
    <xmx:WELxZOytphZ83V37PscaQPVRM8UhnBenszVdE_DQmhdZVq4tCXrP2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 89BB0B6008D; Thu, 31 Aug 2023 21:45:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <6ddd3504-9833-4ac8-a30c-cd63494f7ed8@app.fastmail.com>
In-Reply-To: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
References: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
Date:   Thu, 31 Aug 2023 21:44:06 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Helge Deller" <deller@gmx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux Fbdev development list" <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Framebuffer mmap on PowerPC
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 31, 2023, at 10:41, Thomas Zimmermann wrote:
> Hi,
>
> there's a per-architecture function called fb_pgprotect() that sets 
> VMA's vm_page_prot for mmaped framebuffers. Most architectures use a 
> simple implementation based on pgprot_writecomine() [1] or 
> pgprot_noncached(). [2]
>
> On PPC this function uses phys_mem_access_prot() and therefore requires 
> the mmap call's file struct. [3] Removing the file argument would help 
> with simplifying the caller of fb_pgprotect(). [4]
>
> Why is the file even required on PPC?
>
> Is it possible to replace phys_mem_access_prot() with something simpler 
> that does not use the file struct?

What what I can tell, the structure of the code is a result of
these constraints:

- some powerpc platforms use different page table flags for
  prefetchable vs nonprefetchable BARs on PCI memory.

- page table flags must match between all mappings, in particular
  here between /dev/fb0 and /dev/mem, as mismatched attributes
  cause a checkstop. On other architectures this may cause
  undefined behavior instead of a checkstop

It's unfortunate that we have multiple incompatible ways
to determine the page flags based on firmware (ia64),
pci (powerpc) or file->f_flags (arm, csky), when they all
try to solve the same problem here.

Christophe's suggested approach to simplify it is probably
fine, another way would be to pass the f_flags value instead
of the file pointer.

      Arnd
