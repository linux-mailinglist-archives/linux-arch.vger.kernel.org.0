Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74A3C8990
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGNRTx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGNRTx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 13:19:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD842C06175F;
        Wed, 14 Jul 2021 10:16:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t2so3754113edd.13;
        Wed, 14 Jul 2021 10:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jpddBbK7GUBH/m3UB4sVJbslsEL30FqFzIQ3/5AgwUw=;
        b=Hje4Ex5xc3s0O1a07kRaiLE/1Mi1hFAI7RZGQ+ELC7lvJtrCXrxRu087FCcssyGuxU
         iysvxLWvNOCR86kB2/Is8ltLqX92BjWyn+eSHIWrM9VLdzuLkFV06tCTL4pdS7WNImdl
         Xj2/azO5zT3lU5ySniz/UaQYA4+ZIH/mhTzPR/y6haUyEQOXF4OoUkGOtDpRJ2YIFyxr
         Ff/1FrANU8Y8gAWic79Vtl+DDnun2jtYdjwg6c/bKy5+A7dfVBwEzfb+tdf9SzH6PZaM
         O762smPcqNBou13h658IqX3YHvZX0qP5oUUpbLsDDu+gvEzmuZG2t1y4nQH9fmuHC+Ns
         YzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jpddBbK7GUBH/m3UB4sVJbslsEL30FqFzIQ3/5AgwUw=;
        b=mzltYEvsxIXxdpbtU4ZsdFPsT+bSwbenaNON1l6PwLRJX2av/pT+RznAoLoycKtdCf
         1FoUNisrZH8IxFrBXGe8xu4mV6TB+tYAoCxbsC/T0MPQwpAqDYcCwarXMsdHnctUUFen
         lOKKwBLYRwVYEe0TOcqCDMznJQY+uRhFFmfFSDkr3fLzA4JQJXC7YtCjPCmQZ3X1QpmF
         5X4gd6pVTrouBrWvxmNIAmWqX9k4/6waBWC7LnyX8BcT7CPnAJuQuAmgmFRvhmLqJPvE
         Zv2qiGQ/qhKphDLmR6hWPbH6d6zggZnHXzZ9aan1KpDY80SacaVd01pzrsCvpc/wuOWj
         iOvQ==
X-Gm-Message-State: AOAM532+qlJwJtZo0g7GtLCMRyLgvGAdNh2ORRYx1xX1TLlkrgVsNrPM
        07rVDEZa8R48ruJN/6jLsA==
X-Google-Smtp-Source: ABdhPJyVTC0WA9Wy/r4k170BoZKcqgSiRMPyRRIn5eZgJvYEGA46FA7bmydXMJKsIJtK4S0SmVHw+Q==
X-Received: by 2002:a05:6402:3450:: with SMTP id l16mr15104945edc.358.1626283018285;
        Wed, 14 Jul 2021 10:16:58 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.115])
        by smtp.gmail.com with ESMTPSA id s4sm1300446edu.49.2021.07.14.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:16:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:16:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] Decouple build from userspace headers
Message-ID: <YO8cCEiWIpdV5pJI@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <YO7zEFNSXOY8pKCQ@infradead.org>
 <YO8IoNwXS4h26+9v@localhost.localdomain>
 <YO8JPuay5e3wz//n@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO8JPuay5e3wz//n@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 04:56:46PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 14, 2021 at 06:54:08PM +0300, Alexey Dobriyan wrote:
> > On Wed, Jul 14, 2021 at 03:22:08PM +0100, Christoph Hellwig wrote:
> > > > -#define signals_blocked false
> > > > +#define signals_blocked 0
> > > 
> > > Why can't we get at the kernel definition of false here?
> > 
> > Variable and other code surrounding this wants "int".
> > I don't really want to expand into bool conversion.
> 
> Maybe split this into a separate prep patch then.

And get accused of KPI padding? :-)
