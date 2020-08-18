Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F31248ED5
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRTkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHRTka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:40:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1628C061343
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so10222336pgc.8
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ch3OV58IkPdZykabiTW5C4mVF3OzlaCKDtp5K191NwI=;
        b=DYnvUd31Yol0xDsMTII443AXD5SBZUHRBPBVSKFnIfKxZq5cSp3Bc8ihWc7X9kOoer
         7YDPAJt6p40V7jNKuO+C2ZaQryG9rD13tlWTVI20PKG6f1fpvlxWiKoBvHQpXsv8E/02
         XACxvcZsnlIs6M370bs+/dJJCxnJ/K0R1dBCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ch3OV58IkPdZykabiTW5C4mVF3OzlaCKDtp5K191NwI=;
        b=R+YffaiVKW2n0XhrO0zsGyCUmNUuuqYkIAa+aoF92REy7Rxl5aN0OPgZzt/bx37GlG
         gmaU2jG4tcVLxdFpy1aU6oBlxeMWami90qTXbrgQ2teIvTOzSl8rADQzZwFvG5oZ5A+V
         Ily6ho0c80SkWAyjo4+mDiU9s6UIoW8qVgcYTh882bRtDh2sgqIW+Kabd3ucGKrWx8Ar
         RX+wSq6BnVj3F3jWRl2ERlI9ZRtBUrEuyhsMO6hFTS1nTAsZXgStp8Y4Xb9VOFHQwoZp
         0PK6fqjjHiSJn3t8jknMGEK+gfHsgxq/IGBIN7DTtq9KuJiAn13per0+DQmViBLtoKMb
         UbXg==
X-Gm-Message-State: AOAM531lRyyWIR45cgkvEyDwKa7ZdzeOSW28Skwn68/kd6oiqWr1otvJ
        Ak3Kuq7SdwtSKvWHec+TEegVkg==
X-Google-Smtp-Source: ABdhPJzFD2QepABnrJdmhmbyKfy6j0eIjoXbjXujD4lPLNrelLvSz1BFbjW5ovNHdN12KmA5WLvucQ==
X-Received: by 2002:aa7:9d85:: with SMTP id f5mr16545592pfq.218.1597779629499;
        Tue, 18 Aug 2020 12:40:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mr21sm620205pjb.57.2020.08.18.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:40:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:40:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/11] uaccess: add infrastructure for kernel builds with
 set_fs()
Message-ID: <202008181240.0B31CD9@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:05AM +0200, Christoph Hellwig wrote:
> Add a CONFIG_SET_FS option that is selected by architecturess that
> implement set_fs, which is all of them initially.  If the option is not
> set stubs for routines related to overriding the address space are
> provided so that architectures can start to opt out of providing set_fs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
