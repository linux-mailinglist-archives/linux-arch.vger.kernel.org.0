Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7124F353B71
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 07:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhDEFGM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDEFGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Apr 2021 01:06:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5892EC061756;
        Sun,  4 Apr 2021 22:06:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so1373383pjb.2;
        Sun, 04 Apr 2021 22:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fTbn810HKtN/GZd+dZCj8RCoC/4KxCPs7oA5W4KPVE=;
        b=lcLAn8kULzxXgKxShV0AgqXyZVuvRyCyKMeeLGzBGvjWr7mIRSTJD1+r1qPGJ1EgsG
         mr9VH5qCnGODUNz7i75WS8IjkIsjtYBylmrnRkAr/+/+IPYzfHZlYnRffKaNsJjMZpkm
         Wfv7W78b7hKqXb5Z0gc/P85tMkBiY3uBAj/Y+p0O9vlrueO2Xfig3pXgoSLrkik5i+Is
         1TTfFljgGBD5tDba2M3B+USQAJVZrbNEUdNo7yDijYDoGPAThekRmqNijVBgB04UQ0g+
         aC1/jEmd8tGSQFaFf65hgwPJMiLzNOlgn3+xy1mtpm3NDzEFh6PzUiGoh1Rq+ZnNiDgw
         7qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fTbn810HKtN/GZd+dZCj8RCoC/4KxCPs7oA5W4KPVE=;
        b=Uq/CH+897fDhw4f1gaDxgWlEEifaBQV98vq9mEzx9uNqjN+cEjhkSJESHC8yhoT/zg
         FkPi9I9vaTugMwH+TUTGVPQK0fDhtNkZb8F901/Q6ViQz6iRr+/pRjJbTk6YXiAFLXSQ
         HElYcaOb1aoh9GvKpLl3yX3rr4d/nYb1yFA/5++9ulVBiLdShM5mX0/iYz5lizsQCvH8
         +2LjTmDu191c7QhLDqpIieuDT0TyHzqZFTsbPKQ4bLD1Cqu17t/nDcxw6gm0TNVL/+q2
         Lqz+ZSRtTnvWwW8oFlFjeeBYoxoRsQnpuJEmOeSsd1Tc6fwzVPOV7at0cfTtgGgwmz8D
         8/Kw==
X-Gm-Message-State: AOAM532cWKrzp/xF396mWi9xUcT+yS/V03v2C+jYlOmcsHHp/WuD3gWK
        lPrQdPxE7JEFr4oHneD/+sE=
X-Google-Smtp-Source: ABdhPJyF3TpYVCScDyhQYs9t8pf0zVDvyUve9gBh0d9Z+/i+q0bTH/Pl0G9hBaDGosAAAkd3neTyWw==
X-Received: by 2002:a17:90a:9385:: with SMTP id q5mr24897665pjo.121.1617599163672;
        Sun, 04 Apr 2021 22:06:03 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id q66sm14846339pja.27.2021.04.04.22.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 22:06:02 -0700 (PDT)
Date:   Sun, 4 Apr 2021 22:03:37 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, arnd@arndb.de, tglx@linutronix.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 3/4] powerpc/vdso: Separate vvar vma from vdso
Message-ID: <YGqaKYnLnvj2brJ8@gmail.com>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
 <f401eb1ebc0bfc4d8f0e10dc8e525fd409eb68e2.1617209142.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <f401eb1ebc0bfc4d8f0e10dc8e525fd409eb68e2.1617209142.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 04:48:46PM +0000, Christophe Leroy wrote:
> From: Dmitry Safonov <dima@arista.com>
> 
> Since commit 511157ab641e ("powerpc/vdso: Move vdso datapage up front")
> VVAR page is in front of the VDSO area. In result it breaks CRIU
> (Checkpoint Restore In Userspace) [1], where CRIU expects that "[vdso]"
> from /proc/../maps points at ELF/vdso image, rather than at VVAR data page.
> Laurent made a patch to keep CRIU working (by reading aux vector).
> But I think it still makes sence to separate two mappings into different
> VMAs. It will also make ppc64 less "special" for userspace and as
> a side-bonus will make VVAR page un-writable by debugger (which previously
> would COW page and can be unexpected).
> 
> I opportunistically Cc stable on it: I understand that usually such
> stuff isn't a stable material, but that will allow us in CRIU have
> one workaround less that is needed just for one release (v5.11) on
> one platform (ppc64), which we otherwise have to maintain.
> I wouldn't go as far as to say that the commit 511157ab641e is ABI
> regression as no other userspace got broken, but I'd really appreciate
> if it gets backported to v5.11 after v5.12 is released, so as not
> to complicate already non-simple CRIU-vdso code. Thanks!
> 
> Cc: Andrei Vagin <avagin@gmail.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: stable@vger.kernel.org # v5.11
> [1]: https://github.com/checkpoint-restore/criu/issues/1417
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
