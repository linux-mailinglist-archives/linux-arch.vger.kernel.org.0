Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85D248EDC
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgHRTnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRTnv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:43:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E4C061342
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so9690018plz.10
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07d8bMVK8nskANdMOYMjUqMmsVvTMTJi5HKNDrCq6hQ=;
        b=gNipVl2c+/nOxG5DyICzsidC3YlLij/C0CSl9peKhMSGPdUxsXnT2I6jx1kAORkjSM
         C4tUBV/kkenul4r6W7N5KQ16Bh0uIaoVMq7cUDJ6zjUKb+A1eOTZL2eQQRD/BSFPFViq
         XVn0GEFQYbcbug0N+pnDa6t3XX6fNZsvlwQbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07d8bMVK8nskANdMOYMjUqMmsVvTMTJi5HKNDrCq6hQ=;
        b=XjOKFXfOkGyuJXHHkdxdV55ilI5aXhU2pTqKmQVW4oFH3jrOwH7TKxeCSsXna+BDdN
         EvwP+Sc1Iy7m8O5KiMGL/DVswEG/9BZ+4VRIMTRHfNNyJu3uTjCpPrReXxd/iKhxWfeT
         S1JkTZQsJogi7cIQSNNYoaV727QrnXNLDUYrU4vvOLJo2r+39OLVG8V8Aej10svXC903
         bmmgIE6d+e+4pir5Xk4+x3Y608eQ5g4NqrZPE2M52iYZfuWPRC9TXnI51wzpLpckR0Ud
         x3tjRG0DNruVahzB4QCU2kLR80gS9/BYAegWab3N2jmvYzAPpFugnQoawRrzbUdqlmre
         BJAA==
X-Gm-Message-State: AOAM532kJw15pY6t9Su7yt9PWFxDktJO3rcVUe5hhoo+pF5NnP8IvW2L
        T8eB6fRPUZxbjPyBf0Pqa2CKkA==
X-Google-Smtp-Source: ABdhPJy2gMhr8aECJvzZ3Ns6OMWEcvMDndJrwdoYkKTN1hLvIYEOowwCdxTiZwMiBrBTpO1TDIVE1g==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr1102634pjh.221.1597779829365;
        Tue, 18 Aug 2020 12:43:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm27334312pfr.207.2020.08.18.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:43:48 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:43:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/11] test_bitmap: skip user bitmap tests for
 !CONFIG_SET_FS
Message-ID: <202008181243.162DE4D@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:06AM +0200, Christoph Hellwig wrote:
> We can't run the tests for userspace bitmap parsing if set_fs() doesn't
> exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
