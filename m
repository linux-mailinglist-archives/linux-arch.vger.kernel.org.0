Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF73B9A14
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGBAcl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 20:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGBAck (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 20:32:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A75C061762;
        Thu,  1 Jul 2021 17:30:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x16so7459826pfa.13;
        Thu, 01 Jul 2021 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=X6ddaC28S6L/gsq8ePFu5nDivQdfogx1DethR95R2WE=;
        b=UnP93AsIPAgl6DVd0zQUK/ZYboAExTlIoTnTpF73m0p8Gd3GgyV/hSUW2WFzn0IkPt
         LjfKB/0zP7iNu1NX+p05AMXOpCif+vzbahOcUYLrmcxoBvjOnEBEkhBTDuiVLIs97vt8
         PgF0YR/viquxczihfbdHaZn1GVg9Aig4+lGF0AzigdILcJxco3Y6ga1CJ8hY31UpbvDm
         dVUpy+h161qtC9iuE5uv5Vz2qmGg806A2wUYzcnopv4ayy3K8DtKiT8xoNYiuk7Oy7BF
         +5n8idlMeXTJzphFAdzLscFh3uMFrL48uBe0FKtrgyAaJhhEl7CNVuCPC3pM0S2UAu1f
         QVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=X6ddaC28S6L/gsq8ePFu5nDivQdfogx1DethR95R2WE=;
        b=fnQ0qnU5MLBRnWHKPw0/Oh50P0WpJiqD7UmDtYUozkv4vC+Hv3hhF9Noy7mAtinKHG
         qVYcA0xc7pt6eUvlfp0IfSXvG+TyvaP33OZOZyxk+s99+Pk4iEmSzcflHc8q6IQIHPrO
         BI4B/qWcf8/PKR5EgDeWzyiQ9YSbkEz/lN1Yp32rfU5zrNU4P0zGntx41imBDNqjLqxO
         BCZLeaVOaeAricR+rjFdrsFwC+AT9MIRoTyKDAoy9Ubqru/ugPZ5SBeXLbDbntfqq2J7
         Ad8AbQ7/UrY8ij9YDxZdxUVJwU2VGFyj3r05+/8xdUDCkNGUWsYzQvwaz0UmCkG9tjOJ
         3BqA==
X-Gm-Message-State: AOAM533RiVu12Xj1OUUoTgdguIpSYOpXrhM7SCIi/JyvAqZ30v+c8qf3
        g2Q6uQl6vqSw/Crx4r3R0Jg=
X-Google-Smtp-Source: ABdhPJwJMd3lXgIfrAdEdvEG6NH6cCOUAvI8o9IteFjyi7nmmTAXJUC+i7n/EfHF1/EMFKwTYwOQ6Q==
X-Received: by 2002:a63:4302:: with SMTP id q2mr2214756pga.428.1625185807889;
        Thu, 01 Jul 2021 17:30:07 -0700 (PDT)
Received: from localhost ([118.209.250.144])
        by smtp.gmail.com with ESMTPSA id c9sm754423pja.7.2021.07.01.17.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 17:30:07 -0700 (PDT)
Date:   Fri, 02 Jul 2021 10:30:02 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86: enable dead code and data elimination
To:     Rui Salvaterra <rsalvaterra@gmail.com>, tobias.karnat@remondis.de
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, sedat.dilek@gmail.com, x86@kernel.org
References: <OF02B93D81.2CCB21DA-ONC1258705.0032D3B2-C1258705.00338684@remondis.de>
        <CALjTZvZCi07iVbEOOn8bduueRFLE3MOicWa2WFvxap+zFzpiSg@mail.gmail.com>
In-Reply-To: <CALjTZvZCi07iVbEOOn8bduueRFLE3MOicWa2WFvxap+zFzpiSg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1625185686.surevoro33.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Rui Salvaterra's message of July 1, 2021 8:00 pm:
> Hi, Tobias,
>=20
> On Thu, 1 Jul 2021 at 10:22, <tobias.karnat@remondis.de> wrote:
>>
>> Hello,
>>
>> I have found your patch to enable x86 dead code and data elimination on =
the openwrt-devel mailing list and I wonder if you can sent it upstream to =
the kernel mailing list?
>=20
> As I quoted, mine is an adaptation of Nicholas Piggin's original
> patch, basically a forward-port to 5.4 (5.10 in my OpenWrt tree [1]).
> Since the original proposal has been sent upstream and hasn't been
> merged, there are probably good reasons for it (even though it works
> perfectly for my use case). Nicholas, any idea on why your original
> patch [2] hasn't been merged?

Not sure, I didn't do much testing or try too hard to get it upstream.=20
If you have found it works and is helpful I don't see why it couldn't
be merged. Feel free to submit it.

Thanks,
Nick

