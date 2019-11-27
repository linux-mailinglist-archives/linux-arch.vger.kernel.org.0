Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7412F10C064
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2019 23:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfK0Wyg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Nov 2019 17:54:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0Wyf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 17:54:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so28747323wra.10;
        Wed, 27 Nov 2019 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ei5H/fe8y0i51Hlp0Sp0kPBO0gWbv7up2qZD6Qbfv08=;
        b=kkXp8Il+CBvPorSOC0gcvVSGexyfvC8aQ2zss1zL7jteVMBM7fcIx2LKXlrGb2cbpG
         lja/0KKJN7NehN5d5+FBJtB0+2pdxHynWwBuaDtSNPqs6WyEoIlBhrjoHkukAP11qlIR
         D8LdvIDJ5lsQe82ap4JuESQ6E7OcKZSigRuKOJ27KodnT4y2HXBrc3jNFLNaPK4beAV9
         gR5wGIPnS3MkaTRLAUxcwjd990+jg4i/y5YDICoAs2uyYJzuBEf0oCARxEDYZkuBQIX4
         a33t8jbMNDPmr6YjghuUjF/kmnWdy8JcCwN2f74v6ynXnaiYP4CkLCezp+bd4802GP35
         wFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ei5H/fe8y0i51Hlp0Sp0kPBO0gWbv7up2qZD6Qbfv08=;
        b=smq91O+YxGxHf05dzTIZWQIKuPGm5JW5cw2aHB04fkvLIiiDYMoKXC/b/nFaJHyMJu
         R+K6GigYPoMgWXr8Tlj5ppai12UNHCnttvYnYphY2pTnnAAg9wW3xpYLw3uTdbUG9SwE
         51UBGZbRMSsI58Vhs6G2lCDLE0RSWM/vsWwPi2S7crbOrbR5migzyLz/Fh6kaU6mFShQ
         u0cdDGhBv64liAoBnvNxMQ8WPDoHaSBLVbstQbpxC57TKcF9tNsHNsdt+7HaCDpWw/PU
         RZ9Y/e/gjWKg4LL3B0OVNhJ7kq5+dTmY2iZTPBOt9gBvnVP9NQhsH2UkbTEV0hYzM37m
         KnSw==
X-Gm-Message-State: APjAAAUwN9sHJj9jJvbJb6fCQ8pUED0XJ9U8x8jKwogXCqLH/g75vhvp
        Y/36IBBZgQrijpn2Is24i7A=
X-Google-Smtp-Source: APXvYqxVuPZ2r3/J9Ch/rtqaXjF6p9MbU0Wm5GniUBFMbqeo80g/fh8zx5Sl8zx+AwsJG67UOkhzfw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr28166657wrp.85.1574895273418;
        Wed, 27 Nov 2019 14:54:33 -0800 (PST)
Received: from ltop.local ([2a02:a03f:404e:f500:2dc4:827a:b71a:1d2b])
        by smtp.gmail.com with ESMTPSA id m1sm20706034wrv.37.2019.11.27.14.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:54:32 -0800 (PST)
Date:   Wed, 27 Nov 2019 23:54:32 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 27, 2019 at 12:53:50PM -0500, Dennis Zhou wrote:
> On Wed, Nov 27, 2019 at 03:55:19PM +0000, Christopher Lameter wrote:
> > On Tue, 26 Nov 2019, Luc Van Oostenryck wrote:
> > 
> > > So, fix the declaration of the 'pcp' variable to its correct type:
> > > the plain (non-percpu) pointer corresponding to its address.
> > > Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> > > raw_cpu_generic_cmpxchg_double().
> > 
> > Acked-by: Christoph Lameter <cl@linux.com>
> > 
> > Maybe a better fix is to come up with a typeof_strip_percu() or so
> > macro for all the places where this needs to be done?
> 
> I like the idea of typeof_strip_percpu(). Luc do you mind spinning v2
> with a macro for this instead?

I wouldn't mind at all (I already thought about doing something
like this several times) but:
1) it would strip any address space, not just __percpu, so:
   it would need to be combined with __verify_pcpu_ptr() or,
   * a better name should be used,
   * it should be defined in a generic header, any idea where?
   * I fear it would be abused to escape sloppy typing
     (like __force and casts are already often used).
2) while I find the current solution:
	typeof(T) __kernel __force *ptr = ...;

   quite readable and relatively easy to understand, the solution
   I have for doing it with a macro (that behaves like typeof) is,
   IMO, much much less readable and understandable:
	#define typeof_strip_percpu(T) \
		typeof(({ typeof(T) __kernel __force __fakename; __fakename; }))

	typeof_strip_perpcu(T) * ptr = ...;

So, if you insist I can do it but I would really prefer not.


Best regards,
-- Luc
