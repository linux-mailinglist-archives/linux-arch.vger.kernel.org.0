Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9069299A12
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 00:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395087AbgJZXBv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 19:01:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395082AbgJZXBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 19:01:50 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603753308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FM5x497Ugn5vE6awV9k+llqrmMsULb8uRQkaeTQ2PPc=;
        b=AfrG+l5TbvZFbY544q96Y0MEwR4XGR8wpCxcV0/4pRAvb1izNPDQOMgnEGDJ5NjwCQRLl1
        f9MOukif2/NWFpooTZYZU6jjVUULHJL0DR+J4hIfvfUXJr8QB4mRq4/aEIPztUWcuxPJh4
        mQmDFdUti6Xu59qO5B5uasPzHWLSnxJ0ZM9fio3THhteFiFHSBcjaaxzVjyVWKBEnhG+4v
        rTusvWtu2xDHfmvRGspSEiMtMsFdajVDDz63B7SgExG+31hukDhtDdKt+43TLwz29U+E12
        96JV8N5Chy8Q+TO+YSjbxAsMdLkEmaPad6KNbUdOCLtQXLstHMAKu7e2cDPKCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603753308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FM5x497Ugn5vE6awV9k+llqrmMsULb8uRQkaeTQ2PPc=;
        b=qgSmfed2SHzx4MqIv9VFW77gBJEOakTZgrnXDOVfNiVh+WC2vmPNgpuwNEBOANVtX3AbLh
        b4rZnwvgjleuMaCg==
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/5] kselftest: Extend vDSO tests
In-Reply-To: <20201026114945.48532-1-vincenzo.frascino@arm.com>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
Date:   Tue, 27 Oct 2020 00:01:47 +0100
Message-ID: <87y2js1tic.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26 2020 at 11:49, Vincenzo Frascino wrote:
> This series extends the kselftests for the vDSO library making sure: that
> they compile correctly on non x86 platforms, that they can be cross
> compiled and introducing new tests that verify the correctness of the
> library.
>
> The so extended vDSO kselftests have been verified on all the platforms
> supported by the unified vDSO library [1].
>
> The only new patch that this series introduces is the first one, patch 2 and
> patch 3 have already been reviewed in past as part of other series [2] [3].
>
> [1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
> [2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
> [3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com
>
> It is possible to build the series using the command below:
>
> make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>
>
> A version of the series rebased on 5.10-rc1 to simplify the testing can be found
> at [4].
>
> [4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests

Assuming Shuah will pick them up:

  Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

        tglx

