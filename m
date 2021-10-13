Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27842B900
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhJMH3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhJMH3X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:29:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E921DC061714
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:27:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3729304pjc.3
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x1Ebcu4q4sojvBysK6NeK0lyMBpBy7CX3GptiOMMz40=;
        b=GbpddXjN019bQRXDXQj4kZZgfvpNA9cDk7qQs6S3vPQNLW6lsorFYr9g4BlfG8r+MH
         umScAii8wL7g7/Mjovb3dW34qcZ1nUli4UtJdgQXZQOIkLCSHGM6H+Tkjgjdjt6bH5od
         a+gBBBgtnRHNxhWlxeaphPwHSjnFpwXmEJLl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x1Ebcu4q4sojvBysK6NeK0lyMBpBy7CX3GptiOMMz40=;
        b=vwor99elCaXLi0Xmoc6P4UJeBM39GPrSuTWXu3tRTX5/CPUDMmiEZhFn5vd2xG0s4S
         7o5eciz7Ja748VC+qvjX8iXM2y/Ljf8G0pcOin3sH3zeU04ktmVD6xyKyuw2uI/sCw6S
         ScuZk6qkIhWONzR51l2K92+lgRPuNdfEyWFQwXkDPddW1JSexL/wxMuVejUhzA+zi5K9
         SmdRCGcaeckknRINaCO79xmn+1y/Kb6kIsyYLx7SIhAX6BE8coKJpHAUi8ZIcGkvduM3
         wg6RUVLsn7EXixrzPNhtZS9EEIP4cgoJT/oGcEccHW8z4DZ4ZAdwQ7KoIcQr9b9s0r/a
         YKeA==
X-Gm-Message-State: AOAM532SENYFrN0szZqu/gXM0bl5bpOJvhnF/MDloB7qMiCXqebkrF6W
        Zpb2qz5L/Zki++c1b86zwW4W4g==
X-Google-Smtp-Source: ABdhPJy6bp8C1wfggIt0cRU76okfX2vFeGYaLqCkxWcLL3pwaky7370uXkBgC65bEOt7+KLhBK5Nag==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr11607404pjr.57.1634110040417;
        Wed, 13 Oct 2021 00:27:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fh3sm4933022pjb.8.2021.10.13.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:27:20 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:27:19 -0700
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
Subject: Re: [PATCH v1 05/10] asm-generic: Define 'funct_descr_t' to commonly
 describe function descriptors
Message-ID: <202110130026.0AB963F82@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <02224551451ab9c37055499fc621c41246c81125.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130001.11A50456@keescook>
 <cf0e465e-e678-692c-3ca5-fde70ba4fc97@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf0e465e-e678-692c-3ca5-fde70ba4fc97@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 13, 2021 at 09:23:56AM +0200, Christophe Leroy wrote:
> 
> 
> Le 13/10/2021 à 09:01, Kees Cook a écrit :
> > On Mon, Oct 11, 2021 at 05:25:32PM +0200, Christophe Leroy wrote:
> > > We have three architectures using function descriptors, each with its
> > > own name.
> > > 
> > > Add a common typedef that can be used in generic code.
> > > 
> > > Also add a stub typedef for architecture without function descriptors,
> > 
> > nit: funct_descr_t reads weird to me. why not func_desc_t ? Either way:
> 
> func_desc_t already exists in powerpc. I have a patch to remove it as it is
> redundant with struct ppc64_opd_entry, but I didnt' want to include it in
> this series.
> 
> But after all I can add it in this series, I'll add it in v2.

Ah-ha! That works for me. :) Thanks!

-Kees

-- 
Kees Cook
