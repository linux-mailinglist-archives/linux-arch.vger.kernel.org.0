Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4137242B857
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhJMHEq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbhJMHEq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:04:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E544C061714
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:02:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1521904pji.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=efB3Lcg8IS6RzUiO27f4O4XhGBeoDlQrvifyp9iElT0=;
        b=Yu/d1w7scx0araRrouwcPv6x4zAyT5UDwg8br0GJKxvpbtbYX8o2X/sT0DZJj85xPu
         GeOG1cedBC9ir+WJzzTn0DlJjTcSrRwmj6JY0uqPzF+FpwjUp67IJwMyMJy7Xmdg24ud
         6JNdT8Dwc4xpSiQj6cf4wp2M/y/7wOCbdXf/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efB3Lcg8IS6RzUiO27f4O4XhGBeoDlQrvifyp9iElT0=;
        b=OKP/eea43B0HrWlFBYy87v9C8WEBHixJAd9T+1VNFkm4PLwXT3ISyjxp6z7Y+1Ao92
         7fpNJLlG1LH5fRvncUXFQ10ePUBO1/1axh3+qP4/w5Sj9lGSf2H/qS9Vcx3IeQkG7Vtr
         W5uQJbqpKTlggzVTxNEDnSDrSxNZKkhu/43dh1N38Zj66SqWEYhcLdTZHLY0idubh0Nz
         Z0coWwHdKmxlsU9Ky1y/FqEau+ciw5GISfXFaANgqf6VxIhcccBSw5Z1Kdtr5fganhjh
         B5UmEHyMyygs04JmyHj+mQ+YujE3GwAfGbjCOmb25W5P+lLiyFY2rcfaT7Fm309nR0RA
         RO5g==
X-Gm-Message-State: AOAM531KSlw8PDhzLRYpQNHNFnxTGhX8SGMLkKjTVyMTPnZ6k58fiSAu
        7mMc6VBUGykMn5e0EOh1f24XwA==
X-Google-Smtp-Source: ABdhPJx2yhgK3ntHhywGbHAC8jYO6ehQsn+GhjQrHT7BjbF3OFKwU6TjoJG8lD6XMAvpgbQCPNEisw==
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr11443156pjb.147.1634108562933;
        Wed, 13 Oct 2021 00:02:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u19sm3124045pgo.73.2021.10.13.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:02:42 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:02:41 -0700
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
Subject: Re: [PATCH v1 07/10] lkdtm: Force do_nothing() out of line
Message-ID: <202110130002.0FC7878252@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <b353a85e50ac336c385b46459a5fc43f4a6171ac.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b353a85e50ac336c385b46459a5fc43f4a6171ac.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:34PM +0200, Christophe Leroy wrote:
> LKDTM tests display that the run do_nothing() at a given
> address, but in reality do_nothing() is inlined into the
> caller.
> 
> Force it out of line so that it really runs text at the
> displayed address.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
