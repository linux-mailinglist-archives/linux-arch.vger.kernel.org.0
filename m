Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52AE42B835
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhJMHBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJMHBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:01:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C55C061714
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 23:59:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso1520740pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 23:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbWxJyRJEHl/HPjM18MBc4UW86o71YsmCHifvlg0XFw=;
        b=FiIeotaiLZjM5LcunU4X/qzxsxhiMl3Xdcp8Hagae/2B4EU8WMw4MmFESoq+m4xoy5
         1RtT3T/31PEKI2vY2Tuy0ECZWJm2gtlT1dFb4pu97SBjhfoTxL8ILyqBgYnzle8RjvnL
         v8B1ZGhYla9IZDDHAcvan/WtrWuHJjHO0ZOYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbWxJyRJEHl/HPjM18MBc4UW86o71YsmCHifvlg0XFw=;
        b=EjcMCR3XErmACbTc2Hj2Gr5MyvESwzEH29vmdot4AywOi3BSOGG/7/PEIaOMlRCXSX
         PtPJmY4ktJ9Syq/aFhwap8JrCYxivLIj+Ge7qWne8IgHrXpAo19Yj4EXTAUPkYsdzLkm
         tQxxIEG6TN0gCKZ+x10K5tfpJVXxlXBUQY8QsunPQAuXAEaaJAegojcpPlM/x1Lu1pH/
         6vs5Xzht5btEmUowbEDq6Kt6JAqaLRui4sxbiHV2cmQ6/JlUdR9ID97PD29Lrh00i11w
         1m3i9SXWzC3aUN0WGtifupUKPXXOoiuMqC6PCRWj6sYJG1SLnekbkcgUq8eIWRHan7v9
         omkg==
X-Gm-Message-State: AOAM530skkiZ6iKfqipRqqkfmKfKd0GW2i7DNVDy9OPQNd9C+jo/D5DH
        066emrQIC45mKFx9ePhDswb0BQ==
X-Google-Smtp-Source: ABdhPJxg04sat7HJ6MeMqkBhaVP4fUMmZ0z8e5MnK+cAmqQm529EHMPH7/ru9Ly6sAXLV57TWcF7BA==
X-Received: by 2002:a17:90a:680c:: with SMTP id p12mr11265943pjj.33.1634108371296;
        Tue, 12 Oct 2021 23:59:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl18sm5422324pjb.3.2021.10.12.23.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:59:31 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:59:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 02/10] powerpc: Rename 'funcaddr' to 'addr' in 'struct
 ppc64_opd_entry'
Message-ID: <202110122359.6A69C54DB@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <892715d6f05fdf6ca80cf88a51a9e55298b68c4a.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892715d6f05fdf6ca80cf88a51a9e55298b68c4a.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:29PM +0200, Christophe Leroy wrote:
> There are three architectures with function descriptors, try to
> have common names for the address they contain in order to
> refactor some functions into generic functions later.
> 
> powerpc has 'funcaddr'
> ia64 has 'ip'
> parisc has 'addr'
> 
> Vote for 'addr' and update 'struct ppc64_opd_entry' accordingly.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reasonable. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
