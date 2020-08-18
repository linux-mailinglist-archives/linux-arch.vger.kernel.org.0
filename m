Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C3248F27
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHRT6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRT6K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:58:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE24C061389
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:58:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u128so10491813pfb.6
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tTVXJslCMG4FZPrEp9hH9OHTkHq0Rxca4OvEPGr6tWc=;
        b=gq7q0z5om3draMDAHbZA5EsU+9Cxa31kwlRDV0/Er1pW+z1qfEcyt1fBlTqBfcrzuQ
         aFdjiDgKpuWSVPZi9X+X5YfGML+Y2qGMfARgkWItiaJiRkKsVFP8BsTtVqxj/gyq+xRr
         nIdAL1x5QDk6qj8TgrGE+NDlIYgLUWG02KDuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tTVXJslCMG4FZPrEp9hH9OHTkHq0Rxca4OvEPGr6tWc=;
        b=GeZxqjg4xNjmLbVXehts77xnUpWnGhXqNNGgBz5zodqCXIGd6gM/Ier1TATyy6PogF
         XVqXLj5j+0m3YJJC/oTTmPBQhzQZmUWFgFT7uHzhMltyuswI+e5VND5+pnYxUJOnlVso
         33F076iXgk27iBhnxOSFVShXICZQyoUzopi/6RSkgIMjsavd3RZ/wS+ahGNKDE5yM+66
         BuSRm1S7KMhty54VEWpH3uPWv8Ne+QdwF4WjgF7t1CsF4eu+k7sVv3fpfoFNnmsDRo08
         NZYF0XnqJOkHvENbqnP5JqC7UfQOfbe/d579+H89+7B4FPQrDub+w7LhmxB0Cl80ops9
         HBhA==
X-Gm-Message-State: AOAM531ItUs/Y257WPAxbmgrRhr7XhlNXMNgNXeelVhhBwlsIgD9/GY0
        c1+7dqArZDsbj6Y8epwpgehPkg==
X-Google-Smtp-Source: ABdhPJzDuczrA0WCZ4sUiY1oiLdPBuW8K0ScYn5uoF33E0VkFPD//MrtFx8TGA3olMNvjK57e1u3JQ==
X-Received: by 2002:a62:d149:: with SMTP id t9mr16393509pfl.59.1597780689592;
        Tue, 18 Aug 2020 12:58:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm24551207pfo.49.2020.08.18.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:58:08 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:58:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/11] fs: don't allow splice read/write without explicit
 ops
Message-ID: <202008181256.CABD56782@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-4-hch@lst.de>
 <202008181239.E51B80265@keescook>
 <20200818195446.GA32691@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818195446.GA32691@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 09:54:46PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 12:39:34PM -0700, Kees Cook wrote:
> > On Mon, Aug 17, 2020 at 09:32:04AM +0200, Christoph Hellwig wrote:
> > > default_file_splice_write is the last piece of generic code that uses
> > > set_fs to make the uaccess routines operate on kernel pointers.  It
> > > implements a "fallback loop" for splicing from files that do not actually
> > > provide a proper splice_read method.  The usual file systems and other
> > > high bandwith instances all provide a ->splice_read, so this just removes
> > > support for various device drivers and procfs/debugfs files.  If splice
> > > support for any of those turns out to be important it can be added back
> > > by switching them to the iter ops and using generic_file_splice_read.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This seems a bit disruptive? I feel like this is going to make fuzzers
> > really noisy (e.g. trinity likes to splice random stuff out of /sys and
> > /proc).
> 
> Noisy in the sence of triggering the pr_debug or because they can't
> handle -EINVAL?

Well, maybe both? I doubt much _expects_ to be using splice, so I'm fine
with that, but it seems weird not to have a fall-back, especially if
something would like to splice a file out of there. But, I'm not opposed
to the change, it just seems like it might cause pain down the road.

-- 
Kees Cook
