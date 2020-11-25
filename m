Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1B2C3F66
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 12:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgKYL5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 06:57:47 -0500
Received: from ozlabs.org ([203.11.71.1]:58879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgKYL5q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:46 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsg3RSRz9sRK; Wed, 25 Nov 2020 22:57:42 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, anton@ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        nathanl@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v13 0/8] powerpc: switch VDSO to C implementation
Message-Id: <160630540103.2174375.15062873523136699514.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:42 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 3 Nov 2020 18:07:11 +0000 (UTC), Christophe Leroy wrote:
> This is a series to switch powerpc VDSO to generic C implementation.
> 
> Changes in v13:
> - Reorganised headers to avoid the need for a fake 32 bits config for building VDSO32 on PPC64
> - Rebased after the removal of powerpc 601
> - Using DOTSYM() macro to call functions directly without using OPD
> - Explicitely dropped .opd and .got1 sections which are now unused
> 
> [...]

Patch 1 applied to powerpc/next.

[1/8] powerpc/feature: Fix CPU_FTRS_ALWAYS by removing CPU_FTRS_GENERIC_32
      https://git.kernel.org/powerpc/c/78665179e569c7e1fe102fb6c21d0f5b6951f084

cheers
