Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABFD3DD0B7
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhHBGnA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 02:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhHBGm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 02:42:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94CC06175F;
        Sun,  1 Aug 2021 23:42:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4so9716391wms.3;
        Sun, 01 Aug 2021 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLpYFCEhMxHCYOJofpDOBnsrLOpomdik6GbpkfmrbEo=;
        b=lxYQjRPo7UXjm1H9eY2abYSOBagbxy3grS+nrpt94yVfDuQQDLFjSmpCYReTly+NMm
         Fb6o6xPlrEvvPdY8iATiegFaJBfJZcLKN7qmg41+a3vxxiKSeci7BsXBn9ENnmruEGlq
         3zuZW8DQwMUpuVkUruZBRpZSZqEM315zhCaBaLmzhoFJ1kHytRaJSbTwRaQRr8hpPXxY
         +lGpN3+bZA6IDCwCs4eiFX/kT9Vwtc1kxR1HgqqYtjjrSTUQejSXSasuw5Xs9eHBNwYf
         6p/J4vr35PGVCXSyjTmyr4Sk494k8jwZpGauPdepm+RZ5xQdV1raeOuly+kut0V0IRAS
         xGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLpYFCEhMxHCYOJofpDOBnsrLOpomdik6GbpkfmrbEo=;
        b=TwXP0BI+IlaiYPJ9T5YEyBGkDmOTLb7/peCzenDZAIYPqJ1XsKhvOwBL1dzpVVvwKE
         Qt51u6C+6wxCAxoK/WWakGjWoQDpSKvmHWzRrIwRqXLIahk/jitWc2/SuxFD6ViS3rnM
         inVuhjlvREzmJShIMFEikNVziKQDQfOxMzv8EaWltq4m5eBnMrwuYVcSk4yAPiJ0wAaD
         gyi8yy2aWzgbn8Qslcbow6E5XEEqQd76g9IMar7mCnQREcMs5r3v9SJf4l/Fo0EXsS6H
         K/0O/VIYEet8ct4PUehtk9kwaLKYKrVFWgBQW/M9WsRYzph8XKszLj6zufIBXkzqMMiM
         aO8g==
X-Gm-Message-State: AOAM532SVU0Uma5wPaVgBXzwin/CkZyFW4YkQ4iyKkc0XIwVuhhKRfR3
        rXIw9PA4GPI3kxGR6umr+g==
X-Google-Smtp-Source: ABdhPJxo16iUjyVIeQ9xmvVvuQlDGuzxRLyLiI++9qUbTiA6r1gF/Vs2kZ1oNCsICDMajf7DIB0MlQ==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr10525990wml.84.1627886568347;
        Sun, 01 Aug 2021 23:42:48 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.142])
        by smtp.gmail.com with ESMTPSA id k186sm11178355wme.45.2021.08.01.23.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 23:42:47 -0700 (PDT)
Date:   Mon, 2 Aug 2021 09:42:45 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <YQeT5QRXc3CzK9nL@localhost.localdomain>
References: <20210801201336.2224111-1-adobriyan@gmail.com>
 <20210801201336.2224111-3-adobriyan@gmail.com>
 <20210801213247.GM1583@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210801213247.GM1583@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 01, 2021 at 04:32:47PM -0500, Segher Boessenkool wrote:
> On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> > In theory, it enables "leakage" of userspace headers into kernel which
> > may present licensing problem.
> 
> > -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > +NOSTDINC_FLAGS += -nostdinc
> 
> This is removing the compiler's own include files.  These are required
> for all kinds of basic features, and required to be compliant to the C
> standard at all.

No they are not required. Kernel uses its own bool, uintptr_t and
static_assert, memset(), CHAR_BIT. noreturn, alignas newest C standard
are next.

This version changelog didn't mention but kernel would use
-ffreestanding too if not other problems with the flag.

> These are not "userspace headers", that is what
> -nostdinc takes care of already.

They are userspace headers in the sense they are external to the project
just like userspace programs are external to the kernel.

> In the case of GCC all these headers are GPL-with-runtime-exception, so
> claiming this can cause licensing problems is fearmongering.

I agree licensing problem doesn't really exist.
It would take gcc drop-in replacement with authors insane enough to not
license standard headers properly.

> I strongly advise against doing this.

Kernel chose to be self-contained. -isystem removal makes sense then.
It will be used for intrinsics where necessary.
