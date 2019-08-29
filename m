Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1EA19EC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfH2MVV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 08:21:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49982 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfH2MVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 08:21:21 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3JQU-0002fL-7V; Thu, 29 Aug 2019 14:21:18 +0200
Date:   Thu, 29 Aug 2019 14:21:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
In-Reply-To: <20190829111843.41003-6-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-6-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 29 Aug 2019, Vincenzo Frascino wrote:

> As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove

-ENOSUCH commit ....

Just say:

VDSO_HAS_32BIT_FALLBACK has been removed from the core ....

Thanks,

	tglx
