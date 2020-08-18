Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826DC248EA6
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRT17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgHRT16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:27:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48306C061343
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:27:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so99pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OKHnQstXsjpvLQxUlisdTJtu9Dd8qDjYq5doku9nVeE=;
        b=QyAICf9KgEuQclheMs291Y2a3FseDYQnvIJBXSVKceC05GiYVUH/tD1F9dAAB5jkXy
         Me3o5mBj6v6tVYtlZzju1/QJkfKLhC8WNZX9tDDnxjAN8yhxm10fq7Jif8C/bBou8u+w
         jcMFSVqMPG6wDNRIQNDJc3hml8vNrisx1y6/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OKHnQstXsjpvLQxUlisdTJtu9Dd8qDjYq5doku9nVeE=;
        b=tU0cMF8E+81gTJPqp84i2QqbJvgctb5cYFeEVQf2eVsOeyBaQxMo+QkbXKKqHp3MBR
         FovIJ80W18Ry+unLoe1YfxbeQNBQY7HOSklH7H45DfwfoNjJ7cUt4EkbJnQOhhG1lLdX
         7Clv+FlRCDLHUE7PzK9mRuxuTqDxU8aycETiQ+xEB4uuGUItQPN3TRWPVxuV6UA44PY9
         Ko+gSvsOwTaS+QkJOj/mmO6s9PU7eHBuVIZ1fPxVnhW0VBWW/aUHKVRMbi8Kz9GvAb1t
         aJcEyuYR54l+uzlgOjKBT+Qp7TGdxESTE3XDH3BSjzy8k5G7GQ63LcCp6skRIMNA+NWc
         j/0g==
X-Gm-Message-State: AOAM533S/Sl7fyPsCkwOKH/2FQLQ50Xr/juMBX2RlJQxvA/cwNl/U9Pu
        /HujImTKI/R88/vtV6/iurXm+gJMJlpvmg==
X-Google-Smtp-Source: ABdhPJxbgaFuRtRGjA2NiMRtgl4s0aHVu6/1aAGF8JszULXuHhAcX2HCnNgmwLKolI+rcXeKrqOhSg==
X-Received: by 2002:a17:90a:8904:: with SMTP id u4mr1182215pjn.87.1597778877709;
        Tue, 18 Aug 2020 12:27:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm24777979pfn.77.2020.08.18.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:27:56 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:27:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/11] x86: move PAGE_OFFSET, TASK_SIZE & friends to
 page_{32,64}_types.h
Message-ID: <202008181227.C3A84957AD@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-8-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:08AM +0200, Christoph Hellwig wrote:
> At least for 64-bit this moves them closer to some of the defines
> they are based on, and it prepares for using the TASK_SIZE_MAX
> definition from assembly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
