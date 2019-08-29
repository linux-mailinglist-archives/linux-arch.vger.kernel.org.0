Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A9A1EDB
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfH2PX0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfH2PX0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:26 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A3923426
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567092205;
        bh=2+HFlzM/yfynG5ANvTwsYTNcTosDJEfLB1NO1x5eKc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GAVnAPkSxjpWAZC93k6hMInjPRKhvc39VTMjooTTdWO7dn7yisl64tavG1j2Q2ZLU
         MPrSp8U6Vp6wzEg8iWg3R11+R4lOJYRZ6GR2hzR0ihp2fXafPxntv2PlfPsUBCso/C
         z+0HR98BCFWc7g/gTOZ9HLJZmXNUr9gddpHfPWcA=
Received: by mail-wm1-f41.google.com with SMTP id o184so4290493wme.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 08:23:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXxlGb8dT1PtsrGWBQVpOB1yMOBgefvUr22yASN9FTGBdVGUqyk
        8a7m3KPj2OPXDPhQ0nSkfsd+nflEmePiVxCZz0ybzw==
X-Google-Smtp-Source: APXvYqxvavrhFMLKkvBENomgDKP8QLeedIChXt62FYtW3S9te9FAf4UqqaK8w3TWd/JOSNU9JURf6QE1EcsgN2GtvFA=
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr12797740wmg.0.1567092203251;
 Thu, 29 Aug 2019 08:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-3-vincenzo.frascino@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Aug 2019 08:23:11 -0700
X-Gmail-Original-Message-ID: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Message-ID: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Subject: Re: [PATCH 2/7] lib: vdso: Build 32 bit specific functions in the
 right context
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> clock_gettime32 and clock_getres_time32 should be compiled only with a
> 32 bit vdso library.
>
> Exclude these symbols when BUILD_VDSO32 is not defined.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

BTW, this is a great patch: it's either correct or it won't build.  I
like patches like that.
