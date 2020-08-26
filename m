Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8B2534B0
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHZQUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgHZQUq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 12:20:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D48C061574;
        Wed, 26 Aug 2020 09:20:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so1123226plk.10;
        Wed, 26 Aug 2020 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+gFxa6mV/dX1dFCBtC2xOtSeE1QQdKAWrajpPbfycck=;
        b=lyXYghMrnRsy3FpCr4AoQmKaZJOTWa0XdSKtjtXFSo7t5sdVS6sNr77I+PEJ4Pa6qV
         17ADvEsT5pTzYjNFWe/3G6MjBv53R8PPjmH4NERp+ePjdPORiMZbrfBBf4nWwLsi5VfU
         qyPUMgn4gBD/EylLGvUscir654O7fAKUkB8+j9eAPnyAaa1mW4ERgUdIawCuy2vACsyl
         xWFhU4cMmlM2AwuDpn471FIeZxCisuZM5za5fJVL9Bg9IO8BbN5qdK2x9PalDbwvg84i
         PEUmxcYoWG0RGC86JMwTMdQAD85Q6+KwtCDL+h3Yc+2jgrW+ZksycWAahqMIX6tuBbtD
         2gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+gFxa6mV/dX1dFCBtC2xOtSeE1QQdKAWrajpPbfycck=;
        b=Bgg5uuuyAY9wqCN7qzcc+2WSHTTF4351FvZodFNSf1nEpVuQ+EsIvsUkmKU7K9eOAP
         BSOEZf+4XiW1ITy7D26sFa2uXUAG4azzN+UuN3p/GpPI1feF+kIaZxa5Wxm43Yy0AnXa
         UMSgcYBZHAzpITtaoFga4OY+lYX3kiMQbaOKjtQVsK9A+n3TaqjpaLvDAqh9Rf9ol32V
         w59KNW6Nvpu2cHXcyvRAc+24xuFJ0PDGmMQ5HKDrzN0tS2W8hqHUT2V2wVRLYnT5CHJ0
         Bd3WhGGnaZqXi7dlQbMRohDJtstgVw4MVEZn1y8KS65PEE78VWhlUx/MNhRCtoM+CCD/
         kPWw==
X-Gm-Message-State: AOAM532c+RcKY5d/kQbh5p+SZiQ5SSo1jKb0XGQILakHE4RQWShpKWvg
        M4ATU6wxAde9ytI549O9GCg=
X-Google-Smtp-Source: ABdhPJxduybij+lj3whYtH300CUDZDncU2wg5pWzfaYs4zZ6iQOFKaGFzZiG9cdh/d4Xs3xWY4c/Jw==
X-Received: by 2002:a17:90a:f310:: with SMTP id ca16mr6782701pjb.120.1598458845724;
        Wed, 26 Aug 2020 09:20:45 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id c143sm3674575pfb.84.2020.08.26.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:20:44 -0700 (PDT)
Date:   Thu, 27 Aug 2020 02:20:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 05/23] arm64: use asm-generic/mmu_context.h for no-op
 implementations
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200826145249.745432-6-npiggin@gmail.com> <20200826152510.GB24545@gaia>
In-Reply-To: <20200826152510.GB24545@gaia>
MIME-Version: 1.0
Message-Id: <1598458759.6wa1mql9py.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Catalin Marinas's message of August 27, 2020 1:25 am:
> On Thu, Aug 27, 2020 at 12:52:31AM +1000, Nicholas Piggin wrote:
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>=20

Thank you, I see I stupidly mis-rebased this patch too :( Sorry
I'll fix that.

Thanks,
Nick
