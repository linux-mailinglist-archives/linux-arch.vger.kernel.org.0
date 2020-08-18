Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D8248ED0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRTjl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRTjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:39:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED479C061343
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:39:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so10237209pgb.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+piZ95CVdXuEkGHEl46eIFq4d8k/PB4mXonDrPOqmKY=;
        b=DGsd0rtAn+EKPFELhI752sDGcE5zFP+lMM8VmIoSeKoi6jMm45lvXfr9ws3MF5gc9l
         ve83Lz6XbS7dssqMUq/Lj8oMpn26ngBCwqg5X60YndlWLYNUsBegqrWnarq5zy/QGoxV
         hEAeArB2aRBW8ao8Fs7gzHlcJiD2QfQeaGNvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+piZ95CVdXuEkGHEl46eIFq4d8k/PB4mXonDrPOqmKY=;
        b=Al0SEnuK40FtgxkGMPCMcr4Zi/Yg3KRbmF0vQ9eWjSBIOdeMvc5ytl1/bb2I65kHQF
         i4iuTwxvTyE0/PqH9zW84eswbgJNoN99McVt5EkZ8Rl9aVWkyOr+wdDAQmBP/rS2j8GJ
         COhflEH6HTH56OWkbcSexQw/ZgVFBV/5yRsQwhrHkziUD5F9z9P9Xzcc2xQ5dmBfdF6F
         q0y8HCx9KM1/HW/56zUmDV9zl6PfY6kuu9m7BozgMjq4uGSfnIAkCkmlljBR0CZ4TV/O
         st3/GyjB8TnOQo/ufCGLbPLDpgKujIUEbopZsXFpon/MJFb20ODg5OAzo3C2s/42mn5Y
         ndKA==
X-Gm-Message-State: AOAM530/f4Kjy8t9YRlIirZ9ZvcvAg/eiwIhbI62War/KDGczcM0oflf
        Xar9qZFdxkOZN7C11ti79W+PTg==
X-Google-Smtp-Source: ABdhPJxnDPhmwuColVON9fsNG6lMLA9e0FK5CJwZp+zherGpkgz5W95vJkHLhp5Y28PAYw30OH1SVQ==
X-Received: by 2002:a63:d1f:: with SMTP id c31mr13717358pgl.27.1597779576171;
        Tue, 18 Aug 2020 12:39:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c27sm22083011pgn.86.2020.08.18.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:39:35 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:39:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/11] fs: don't allow splice read/write without explicit
 ops
Message-ID: <202008181239.E51B80265@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-4-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:04AM +0200, Christoph Hellwig wrote:
> default_file_splice_write is the last piece of generic code that uses
> set_fs to make the uaccess routines operate on kernel pointers.  It
> implements a "fallback loop" for splicing from files that do not actually
> provide a proper splice_read method.  The usual file systems and other
> high bandwith instances all provide a ->splice_read, so this just removes
> support for various device drivers and procfs/debugfs files.  If splice
> support for any of those turns out to be important it can be added back
> by switching them to the iter ops and using generic_file_splice_read.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This seems a bit disruptive? I feel like this is going to make fuzzers
really noisy (e.g. trinity likes to splice random stuff out of /sys and
/proc).

Conceptually, though:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
