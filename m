Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDC3242690
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgHLILd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Aug 2020 04:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHLILc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2020 04:11:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4CC06174A;
        Wed, 12 Aug 2020 01:11:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so624995pfb.6;
        Wed, 12 Aug 2020 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Gqk0IHazkAbnd1TceTY1ZmQMSGqDC0SOsCEO7z8wdv4=;
        b=eDg4DOyGlwZXAxfvrAWm2bCGM35Xhc/MB9AlQ5a1VVdBg214Fqq5NUhxfeckALVZVq
         wshSpJhFV1UCo2gBcr2GGbD55UBFts6DFhFkvmTXBF0lBdloY7tgosoqUiST7/3+f4Wy
         m3UjaCLNjlrWpvYZYHC5+klYfXP17VtghaLl7pRWaAMR1WBENVLQYlEANV+cZudg+7PM
         KSCK/45JABfmQvheqKAbLQdbOnlT99QuAvOj6/AID7IafCM387DZA3oBUkeCAl910hCa
         Kmo6hG6oIwJngdWFZ2hs+X4wZZ/80PKxgjTW96HR0Zh6X+gJwR38Uq7MueTEyFISYi1X
         O91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Gqk0IHazkAbnd1TceTY1ZmQMSGqDC0SOsCEO7z8wdv4=;
        b=FHEWypDB7Rw6tWgXbqkxzt5VbfzfBfI+26tRkYesXZSYgjIzC1ypKl+VxDZLGzWaS2
         c5HUh48IrriCTSU4ARwqqKlcPtaEvC+R6QMvz9vNZoZAM7M9C5l+dwiWwyswh/XCmiKH
         GYoh9q3gpFGK6npVg3HBHn8qAK0uPCboMt/B4pGBImbHixeFSBbRjuXL31EOLxgvse8K
         aWaGOaWcZTACrBQ1MWovSMTypnnQQBX711jrPAgMXu+0W4KrYAgXvQCbgsv0X2++WjdU
         MK7JbchyB46lKEXzzB5KdY22adaxDocGicJCXlk3ZaBVyTQhVhmPCDnranSCxuM/zc4h
         VlZA==
X-Gm-Message-State: AOAM533ieRYG4Y7CE2jarylOJIRpAFGA51Xc5gn7RqIW3eK2SvQbgEEK
        HifkY0LzPrR6vdhwC6lV0I4=
X-Google-Smtp-Source: ABdhPJyqkUbovHh5ka3/XaSTC8ODlUDFJft07FCaI95cZAdpIni7GZOC8/CuFKmKXdXYaPrreAj/Bw==
X-Received: by 2002:a05:6a00:787:: with SMTP id g7mr9620510pfu.290.1597219892350;
        Wed, 12 Aug 2020 01:11:32 -0700 (PDT)
Received: from localhost (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id w82sm1547171pff.7.2020.08.12.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:11:31 -0700 (PDT)
Date:   Wed, 12 Aug 2020 18:11:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/8] huge vmalloc mappings
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zefan Li <lizefan@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        =?iso-8859-1?q?Catalin=0A?= Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200810022732.1150009-1-npiggin@gmail.com>
        <20200811173217.0000161e@huawei.com>
        <d457aabc-9f58-f47e-f5fa-9539618b2759@huawei.com>
In-Reply-To: <d457aabc-9f58-f47e-f5fa-9539618b2759@huawei.com>
MIME-Version: 1.0
Message-Id: <1597219299.b5noer1k93.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Zefan Li's message of August 12, 2020 11:07 am:
> On 2020/8/12 0:32, Jonathan Cameron wrote:
>> On Mon, 10 Aug 2020 12:27:24 +1000
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>>> Not tested on x86 or arm64, would appreciate a quick test there so I ca=
n
>>> ask Andrew to put it in -mm. Other option is I can disable huge vmalloc=
s
>>> for them for the time being.
>>=20
>> Hi Nicholas,
>>=20
>> For arm64 testing with a Kunpeng920.
>>=20
>> I ran a quick sanity test with this series on top of mainline (yes mid m=
erge window
>> so who knows what state is...).  Could I be missing some dependency?
>>=20
>> Without them it boots, with them it doesn't.  Any immediate guesses?
>>=20
>=20
> I've already reported this bug in v2, and yeah I also tested it on arm64
> (not Kunpeng though), so looks like it still hasn't been fixed.

Huh, I thought I did fix it but seems not. vmap stacks shouldn't be=20
big enough to use huge pages though, so I don't know what's going on
there. I'll dig around a bit more.

>=20
> ...
>>>
>>> Since v2:
>>> - Rebased on vmalloc cleanups, split series into simpler pieces.
>>> - Fixed several compile errors and warnings
>>> - Keep the page array and accounting in small page units because
>>>   struct vm_struct is an interface (this should fix x86 vmap stack debu=
g
>>>   assert). [Thanks Zefan]
>=20
> though the changelog says it's fixed for x86.

Yes, my mistake that was supposed to say arm64.

Thanks,
Nick

