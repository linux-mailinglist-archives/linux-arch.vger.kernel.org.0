Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB810F554
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 04:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCDBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Dec 2019 22:01:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLCDBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Dec 2019 22:01:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so1835009wrr.1;
        Mon, 02 Dec 2019 19:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HZYl9ujPBCb4Q8KhFCqYu50tnO5uzcIOpRaURtSjLV4=;
        b=QOLrjCYaBxKjhhZsd6wWwsrpY0JN76eUSuBQRYbPxwRC271sdqVzpNeIRMG8KbovZI
         kYy83hLhtwapkakeoCeqF2btcYS+n3P0LE3pFT1zwDckWZbCZmTtkQYcc/vA29LlLwa7
         DtaKdYUU8+2do7kmE5+ThSCaaWuKIm5ZMQdryvSAUaNfZotK8prpkX/+W3Cn+Z1rIUPI
         slbvt1XKOmiwrm719n75mTorHpGprHHcM0aOFu14gs2Hx//U1ZHc+QfZB8gxchISGUjj
         vg6mFh6b8vvxbRI8mpYeMVxnmt0Pd8uady9sdg+sAUvw23t1wbR8B6zpomolXoq3k+4p
         DQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HZYl9ujPBCb4Q8KhFCqYu50tnO5uzcIOpRaURtSjLV4=;
        b=qjUqjHdtUQi4/pod0gYAlYLjfth3m7nvOxumK6sNrUpR0LkJGvTUyBJfRsXQtYYrqq
         9evmF0m37EkkxDPmo2jCj/3EV6jWJt1Kad3P7y4TgNpdhahDgnQpruHWss1h5t8wUZmk
         YvpS2GR4pRxat2JvsanDLL75t/DzpnzdSsyiXxUBltSKUZfFaVtBgK9qqkRvaCoJHfLa
         AzjdPZujWO5TGUswv5FvQi8zvM7OJ+yhHH0WsRnX+JlaSqkAYgw0ku/FBL8f8PiFA1eW
         UQPpsXE6fX1t2HazTvPnKGD3eWsTZeT9gyKo/kUmqtmp14RZofFt6MsXrphjZkmsJQRR
         KHJw==
X-Gm-Message-State: APjAAAUodWAzwQQW561Lgj0KdtEtQdSlxDz06FmXhG9Q1DydsRdK56CQ
        fYFpE+O/43/sodHKaq0GN1c=
X-Google-Smtp-Source: APXvYqzqkvJ/pKTddWLInxGiinfuFWqn/n+KDdBZ3N6M8mubyY+OUclZB8PYjUK5E0uf3vDQfx7cuw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr2364769wrt.381.1575342070498;
        Mon, 02 Dec 2019 19:01:10 -0800 (PST)
Received: from ltop.local ([2a02:a03f:404e:f500:442d:b656:b1a0:d761])
        by smtp.gmail.com with ESMTPSA id f2sm1269093wmh.46.2019.12.02.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 19:01:09 -0800 (PST)
Date:   Tue, 3 Dec 2019 04:01:08 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
Message-ID: <20191203030108.ch7n6yoqgsco2alj@ltop.local>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com>
 <alpine.DEB.2.21.1911271553560.16980@www.lameter.com>
 <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com>
 <20191127225432.ttwxm3hxtg5utfaz@ltop.local>
 <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local>
 <20191202190718.GA18019@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202190718.GA18019@dennisz-mbp>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 02, 2019 at 02:07:18PM -0500, Dennis Zhou wrote:
> On Sat, Nov 30, 2019 at 01:00:37AM +0100, Luc Van Oostenryck wrote:
> > On Fri, Nov 29, 2019 at 06:11:59PM +0000, Christopher Lameter wrote:
> > > On Wed, 27 Nov 2019, Luc Van Oostenryck wrote:
> > > 
> > > > 1) it would strip any address space, not just __percpu, so:
> > > >    it would need to be combined with __verify_pcpu_ptr() or,
> > > >    * a better name should be used,
> > > 
> > > typeof_cast_kernel() to express the fact that it creates a kernel pointer
> > > and ignored the attributes??
> > 
> > typeof_strip_address_space() would, I think, express this better. 
> > It's not obvious at all to me that 'kernel' in 'typeof_cast_kernel()'
> > relates to the (default) kernel address space.
> > Maybe it's just me. I don't know.
> > 
> 
> I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
> names. I kind of like the idea of cast/force over strip because we're
> really still moving address spaces even if it is moving it back.

Well, 'typeof_cast_kernel()' somehow conveys the idea but sounds
a bit weird as the macro doesn't contain a cast (expression).

> Thanks for debugging this. I'm still inclined to have a macro for either
> cast/force. I do agree it could be misused, but it's no different doing
> it in a macro than by just adding __force __kernel.

I'm glad to help making the kernel type-clean (with the goal of
catching more bugs earlier) but I admit that I absolutely detest
these layers of ugly macros. 

I'm working on a nicer implementation but it's not yet ready.

Best regards,
-- Luc
