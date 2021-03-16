Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12F33CAD8
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCPBTn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhCPBTg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:19:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A978C06174A
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:19:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so498534pjc.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :user-agent:mime-version;
        bh=/aONdzdEHJjSkJXSlFiFKYoN0KeuFnC9kVYyzxSJi0A=;
        b=RqD2ASXEl6CSFthKXJ1Din5qSGTxQXlk4NmPlfBPAVpWph7E3KsycUerhyp1ltrO2H
         yjSGaXVW/1b5rPZjWEQkzBg9kGU5bYjR5gsfSBCIebpipzjYTRAlpN6d+zdZ10w3hYU/
         QD9Me1n/PlGmiTGicRBR5u8yOkv5EgHvj0eTUK4kmDuadMXXdHT7BLbDqXleqktLM8uS
         DtBNnMkh//3X2lS5ezr/u7s+r/L0UjF+7TgEoa/r1vPWjgUoLpR4s4B+2GmhXEVgnXhA
         9tNRqGSmFyrjXi0TbcKpPhoCxj+Dv4ecWav4sGEiF7CV7BOHXOz5m9yQnFlVTH1CmxnS
         XByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:user-agent:mime-version;
        bh=/aONdzdEHJjSkJXSlFiFKYoN0KeuFnC9kVYyzxSJi0A=;
        b=R2uLlC/IpvOOemrg/VW6LY6q/PChH5U3K1I3qE+uH031X3UE615JEZ1eGhlexZW2Fa
         0CmnRYDWUtpkMsCuLT73+BgcoNnOeIwWX6VMXpWqlpTWKInMhATsQFPq7LGXMhAUCv/P
         PK4/yT+bdekqYeps08ph+Bavsycm9OELCdSwjnV61Gbu6nD0+Ll+6Lq3jyV+SES+iPSl
         SS/gx5YfCE9lULWx8c0ojAKWkhNrVHrRJVVuNRgYeDp7gF62RRThL9pTyl9A/DScDuvN
         7iUczRkXrOXg3oUoxlLRKLAU09phH0rODcxCMSM9GdO4+HkfN4MCGj9vAmNVYgY3ffPl
         HUNw==
X-Gm-Message-State: AOAM531UznyJw82s2yCQavS5kZU94P+iHpeStWv9krD99dw0fCpfLrnZ
        mXCQH/VDeWjs0gINfNm0WBg=
X-Google-Smtp-Source: ABdhPJxS3ha9tndIexBTUnNy1ZCXPto5LrXeXHtc9HHfL6R2I1j/OZJtt/5F3syN991kdl42GknAYA==
X-Received: by 2002:a17:902:14e:b029:e4:9648:83e6 with SMTP id 72-20020a170902014eb02900e4964883e6mr13719344plb.68.1615857575554;
        Mon, 15 Mar 2021 18:19:35 -0700 (PDT)
Received: from sun.local.gmail.com (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id r30sm14174775pgu.86.2021.03.15.18.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:19:35 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:19:33 +0900
Message-ID: <m235wvc2u2.wl-thehajime@gmail.com>
From:   Hajime Tazaki <thehajime@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Subject: Re: [RFC v8 11/20] um: lkl: basic console support
In-Reply-To: <1aebaecdb4c5b3e62f5a89618b9d13f237d6b3c1.camel@sipsolutions.net>
References: <cover.1611103406.git.thehajime@gmail.com>
        <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
        <1aebaecdb4c5b3e62f5a89618b9d13f237d6b3c1.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.1 Mule/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Mon, 15 Mar 2021 05:42:52 +0900,
Johannes Berg wrote:
> 
> 
> > 
> > -obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
> > +ifndef CONFIG_UMMODE_LIB
> > +obj-y := stdio_console.o
> > +else
> > +obj-y :=
> > +endif
> > +obj-y += fd.o chan_kern.o chan_user.o line.o
> 
> Might nicer to do via Kconfig, such as
> 
> config STDIO_CONSOLE
> 	def_bool y
> 	depends on !UMMODE_LIB
> 
> and then
> 
> obj-$(CONFIG_STDIO_CONSOLE) += stdio_console.o
> 
> here. Similar to CONFIG_STDDER_CONSOLE, after all.

Agree.  I'll fix them.

> > +/**
> > + * lkl_print - optional operation that receives console messages
> 
> How is it optional? I don't see you having a __weak definition?

Optional is misleading...  I will fix the comment.

-- Hajime
