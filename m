Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72563DCDEE
	for <lists+linux-arch@lfdr.de>; Sun,  1 Aug 2021 23:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHAVkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Aug 2021 17:40:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:44069 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhHAVkb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 1 Aug 2021 17:40:31 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 171LWnvj015149;
        Sun, 1 Aug 2021 16:32:49 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 171LWlIp015148;
        Sun, 1 Aug 2021 16:32:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 1 Aug 2021 16:32:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <20210801213247.GM1583@gate.crashing.org>
References: <20210801201336.2224111-1-adobriyan@gmail.com> <20210801201336.2224111-3-adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801201336.2224111-3-adobriyan@gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> In theory, it enables "leakage" of userspace headers into kernel which
> may present licensing problem.

> -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> +NOSTDINC_FLAGS += -nostdinc

This is removing the compiler's own include files.  These are required
for all kinds of basic features, and required to be compliant to the C
standard at all.  These are not "userspace headers", that is what
-nostdinc takes care of already.

In the case of GCC all these headers are GPL-with-runtime-exception, so
claiming this can cause licensing problems is fearmongering.

I strongly advise against doing this.


Segher
