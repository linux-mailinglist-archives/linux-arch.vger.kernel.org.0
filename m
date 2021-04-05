Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB77353B6F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 07:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhDEFCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDEFCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Apr 2021 01:02:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A16C061756;
        Sun,  4 Apr 2021 22:02:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e10so752922pls.6;
        Sun, 04 Apr 2021 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kK15QIzlv37/lctPxHTH0/oV3sSKj5dMjOshVvLQYOY=;
        b=gyKml+buuchIf9zLiJIVWS/8SzsE3vie/q8RjjEKEoC9X5+eK9qAKzMKWxOYqpa4Up
         KpOAS0eXBL4aKv45eMa8N2NmSLc7tkb95RWRZaSoIH63ICZJNPXiEDntozIZhUQWK8rc
         g9ZOcHM/sKjaEi6WkL/IIcYMgVo73TwCNZ4yx9PdUK4U8kylnrx8RzWbLKyHqZnvQuzh
         Nkb8LsqnLU+RcWB0segCj3iV9VZu/Lza0exBAOkpAmmIPtm0WySWJKmmNPTLLk66UDa9
         C2fC5gvawj5GdnFEj3dCRwmrpDkNOxat2bkijMxV0wYXkDBeDmTecx9/puNx8TNvs+zS
         JF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kK15QIzlv37/lctPxHTH0/oV3sSKj5dMjOshVvLQYOY=;
        b=crOKtCcXZPUa9jv6EP4giL5J+Oqbb8zAmEE48gpcgvgmDFXxMrxaa7N3SgoclZ3rIv
         ETTp8f6ynLPoY/j/yaGI7y/Nz0k6j5tZyWdP/PccJey/HrYIc/692XXzMPE7Ja5/fCIl
         OvyBLkulPSsP+xqbpZzd8Lp7B/xT8JdoiLlJG7aDh89hBAZd0Km3QMimsNC34P44oMTL
         R7l1AcdeGEWHa+NfeA9S5fo8JB6wl5OyQTutDYQsxlUUSRhOM0Os3LKT5xHEjB2/2332
         2gPNuzvtntrbY5LAytJZ+DoXEzzcwIFNpT9Qe96I/l43GLZXVL7U8JWnTmwtL4QPmy9N
         K2Hw==
X-Gm-Message-State: AOAM530egbJDVlzU/w36ABa1x8TLiysPsK6DoJqp1CnoIO6XV1O/KZpI
        slunrs0FGhdRiqrQdyN6ljY7A0J9yD6lxw==
X-Google-Smtp-Source: ABdhPJzLdUJy3dvpZoB0nqEQ8yTO9K/hjp0XKNEZRVpkDvLIZGb27U4wcpyLU1qydKLB2z3nz7DBUw==
X-Received: by 2002:a17:902:7b90:b029:e6:f01d:9db2 with SMTP id w16-20020a1709027b90b02900e6f01d9db2mr22475666pll.69.1617598951642;
        Sun, 04 Apr 2021 22:02:31 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id 14sm14227119pfl.1.2021.04.04.22.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 22:02:31 -0700 (PDT)
Date:   Sun, 4 Apr 2021 22:00:05 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, arnd@arndb.de, tglx@linutronix.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 2/4] lib/vdso: Add vdso_data pointer as input
 to __arch_get_timens_vdso_data()
Message-ID: <YGqZVf5+74RYp8H5@gmail.com>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
 <539c4204b1baa77c55f758904a1ea239abbc7a5c.1617209142.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <539c4204b1baa77c55f758904a1ea239abbc7a5c.1617209142.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 04:48:45PM +0000, Christophe Leroy wrote:
> For the same reason as commit e876f0b69dc9 ("lib/vdso: Allow
> architectures to provide the vdso data pointer"), powerpc wants to
> avoid calculation of relative position to code.
> 
> As the timens_vdso_data is next page to vdso_data, provide
> vdso_data pointer to __arch_get_timens_vdso_data() in order
> to ease the calculation on powerpc in following patches.
>

Acked-by: Andrei Vagin <avagin@gmail.com>
 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
