Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4B3B902F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhGAKDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhGAKDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 06:03:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585B5C061756;
        Thu,  1 Jul 2021 03:00:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s15so7497356edt.13;
        Thu, 01 Jul 2021 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hsl25h4PCog/lkP9UfonImfNMM/KPiN3Xl3ptpN4ynA=;
        b=MWmcLrr1Jc3TDJctM0nSLyxidp2p/9b5paECLpl614AM0m2b2MN7EAk4lGZMZJHRu1
         7LQFHn4vuDwhF4g0OI0Lxz0VjRJZWROeJiH6LQnErS4hSkXzRJCKCC+w+5UNRNDfAeGT
         u0lA2oqybMW8RQ55QWg82gYTI7wGd1Hkky8EApkl7rZbuYMfAiBn9H2Bs5Q/RHwuFUBZ
         SDP1CCSj3N8Qp+0+He/pqeZwUJ0/L3i0lIKHRrdXf897Hz5vH38ltDFYFCxrlsJW4n9B
         6vTlUWzBmYeYt3itlkkUV/hCTIdhJ9FL/BU/R7rmQAXN6juqB4N+FDSh8u8M83OnAEm0
         m4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hsl25h4PCog/lkP9UfonImfNMM/KPiN3Xl3ptpN4ynA=;
        b=KYSg1z/FyR5ScDW38Bt2MAxcIyZy7pvAZKNruuUwpBfA0Ib8NC37Lf4/VhFZAunJ/9
         rL/WMoO8Zf+FBZOCUBWXe9mrSzScQBkmviJbMcHpeiNUHNIm5enXkSCk3C7UIa8vcucf
         nyRf1ULs2Gg31kirgtLopcz43M1mnAD8H4nywrc3p8mVv7JRNRYRAf0ra662yvGsKFhm
         srdtAIB1eNn0uxs5U7j+ddSLPFUgTiezGD6JyfdldXITcrrvyHNeIKrVM4S3r3+P58Aa
         +rYQJCptG40dJBRccL6LqPHKpiuulJBseuqxCBXVsMVU/2N4J/5dZ7cRGl1zKXLGIRVX
         XXwQ==
X-Gm-Message-State: AOAM533aCeIPx7BFVw9GbpC88FYKIPHS2PxMl8/fXvinNh+rXeZKLP/Q
        vhq2W51pLFR0MeiDRFNc5x99U7pGx03unsVScw==
X-Google-Smtp-Source: ABdhPJyMjWNIw3K9l1o8eZyPLrHmiaYRzC3KrAwfJM5vAxmBQZN8/ShpKSdvsTOyNfpk9+wBFYvsZX1B2nRYuQHYBGA=
X-Received: by 2002:a50:a694:: with SMTP id e20mr52429824edc.191.1625133641642;
 Thu, 01 Jul 2021 03:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <OF02B93D81.2CCB21DA-ONC1258705.0032D3B2-C1258705.00338684@remondis.de>
In-Reply-To: <OF02B93D81.2CCB21DA-ONC1258705.0032D3B2-C1258705.00338684@remondis.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 1 Jul 2021 11:00:30 +0100
Message-ID: <CALjTZvZCi07iVbEOOn8bduueRFLE3MOicWa2WFvxap+zFzpiSg@mail.gmail.com>
Subject: Re: [PATCH] x86: enable dead code and data elimination
To:     tobias.karnat@remondis.de, npiggin@gmail.com
Cc:     sedat.dilek@gmail.com, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Tobias,

On Thu, 1 Jul 2021 at 10:22, <tobias.karnat@remondis.de> wrote:
>
> Hello,
>
> I have found your patch to enable x86 dead code and data elimination on the openwrt-devel mailing list and I wonder if you can sent it upstream to the kernel mailing list?

As I quoted, mine is an adaptation of Nicholas Piggin's original
patch, basically a forward-port to 5.4 (5.10 in my OpenWrt tree [1]).
Since the original proposal has been sent upstream and hasn't been
merged, there are probably good reasons for it (even though it works
perfectly for my use case). Nicholas, any idea on why your original
patch [2] hasn't been merged?

[1] https://github.com/rsalvaterra/openwrt/commit/0082c486b5637dc8e1771e2b9b38b728cb2fa01d
[can be rebased at any time, caveat lector]
[2] https://lore.kernel.org/lkml/20170709031333.29443-1-npiggin@gmail.com/]

> It works for me even combined with the new Clang ThinLTO kernel build. @Sedat you might be interested as well, as I saw your attempt here https://lkml.org/lkml/2021/2/27/181

I haven't tested with Clang, only GCC, but it's nice to know.

Thanks,
Rui
