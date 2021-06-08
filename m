Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6639ECCA
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 05:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFHDOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 23:14:39 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35428 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFHDOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 23:14:38 -0400
Received: by mail-pl1-f171.google.com with SMTP id x19so2713472pln.2;
        Mon, 07 Jun 2021 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=dTKE13akXye7XOJrSySmUD4YdhMpmg7p/bPzllhdc1c=;
        b=Sri8V3ycW3FJB7nLzmqz0afeW7dxQXb/kAmro1fv/9NZyJ7opSk/eMUz/2X4csIk17
         DBYRhuujk+4AF1N6FdT91gx2Llz7yvu5u5WasuapqNuJaFP/8Znh+DsoGdb5/cBsF1w4
         DcVy7zxIA8DjoyNzKevhu4W86Lz6FT8Kfr1TpBg5MFofUKBC0q4su2fARQehdFg9sv5s
         pm2KAd0gyQ2lOSVjdMu5+aqpZ2g+3ekNZrfb7yyX3QY/U4h8L7BOuyTyhu5zTmgtnheO
         RcYsg6xnTNzTJPQpUsYx8968CPtHGKO4G+kqhv4Oa4bWVBb8FrXjjH38FNWRmTyEcr7s
         yFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dTKE13akXye7XOJrSySmUD4YdhMpmg7p/bPzllhdc1c=;
        b=J9v8033EbH4yMSIf5lq1vrNJ/5fnspMLvKJs1FcYSFzG3HTwT3BsWTGu+t+HnIy8Tk
         KYvt9Umqw1437OKz+VKVlLZkY0ByBYBwz1n69zIR5V1T6dLeetswdGL6OMGlMxijHpDM
         SWYQvckVJCnUGOk6dZxo6zleQXuxBoJ4rFwys9nCGuVR5t1OFBdspdUwM25j9uhkjOmn
         SRZeh0q9JXd2vzlmnc1ziWa8FuSDY+EBRh/wstFYppUH9VufUgnLiMaUuv45UU/tyMwB
         1V1q40ffcq6O/w+cRJWARtA9xdbdQVToQOnXCz/sShze08v7xmT+TsVob5eUwbrySEgM
         LSiQ==
X-Gm-Message-State: AOAM533QUE8Drz5nggHg8Ig7DppiAbHVkjtYAONIpq0rj0KLwYaem6er
        29JH+u+eL9VbZHIjh9tEh/o=
X-Google-Smtp-Source: ABdhPJwSOpFSmciqtMoVlA713sykrsY6pkKYM6papRQiSUGgcieRkA25/e0j0f2w2JnCcU3MhZadCA==
X-Received: by 2002:a17:90a:5507:: with SMTP id b7mr2395216pji.27.1623121895340;
        Mon, 07 Jun 2021 20:11:35 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id c21sm9244091pfi.44.2021.06.07.20.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 20:11:34 -0700 (PDT)
Date:   Tue, 08 Jun 2021 13:11:29 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
In-Reply-To: <20210605014216.446867-3-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1623121605.j47gdpccep.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Nicholas Piggin's message of June 5, 2021 11:42 am:
> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
> when it is context switched. This can be disabled by architectures that
> don't require this refcounting if they clean up lazy tlb mms when the
> last refcount is dropped. Currently this is always enabled, which is
> what existing code does, so the patch is effectively a no-op.
>=20
> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Can I give you a couple of incremental patches for 2/4 and 3/4 to=20
improve the implementation requirement comments a bit for benefit of=20
other archs.

Thanks,
Nick
--

Explain the requirements for lazy tlb mm refcounting in the comment,
to help with archs that may want to disable this by some means other
than MMU_LAZY_TLB_SHOOTDOWN.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1cff045cdde6..39d8c7dcf220 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -419,6 +419,16 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  shootdowns should enable this.
=20
 # Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
+# MMU_LAZY_TLB_REFCOUNT=3Dn can improve the scalability of context switchi=
ng
+# to/from kernel threads when the same mm is running on a lot of CPUs (a l=
arge
+# multi-threaded application), by reducing contention on the mm refcount.
+#
+# This can be disabled if the architecture ensures no CPUs are using an mm=
 as a
+# "lazy tlb" beyond its final refcount (i.e., by the time __mmdrop frees t=
he mm
+# or its kernel page tables). This could be arranged by arch_exit_mmap(), =
or
+# final exit(2) TLB flush, for example. arch code must also ensure the
+# _lazy_tlb variants of mmgrab/mmdrop are used when dropping the lazy refe=
rence
+# to a kthread ->active_mm (non-arch code has been converted already).
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
=20
--=20
2.23.0

