Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACC26A486
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIOMAM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 08:00:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32882 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgIOL7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 07:59:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id e11so10944251wme.0;
        Tue, 15 Sep 2020 04:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IT9TYa324z97FaDa7D5p2wa9NqPdqT/+VgBeB+G8GM=;
        b=ugsCZBOZzZ8gcfuBVbdqrP30xu8+BHfoOQjW7Ov3u2Jy+2Q/SAxMdQQKax8zYzcgim
         EFQIs5Huc5uJVRc49ZpB2wInIIbdvOK1xHOPtolGhC2QStPonyB6mp6bIDYT28g9U+tz
         dmNOyZcKsnWCivWWhKQjvHtRq/LfAJAXM4qb2LGnelQIcZm4MJPukEwjNTkaSVBZobNb
         zO9uxN9HcDBPL/aXgXC8Z77cTq0QZOe6C1c4+vx3yIgNdsRxZN21K26au83m6NumZJR8
         1QTeYtXtN+RoyOgIlTGuxgPAg0q5ox31hDJayR2xFG1z4xtT+BLv449hWhDjjzIXXNGC
         diZw==
X-Gm-Message-State: AOAM531ASuxKSfJZhZQxn6hych2ySarCOywL8EDLpVmpgj2uPwT174QO
        JD6LWPYEdtaQMCbY1lf75rk=
X-Google-Smtp-Source: ABdhPJz4L2F5DwXsSda6AFOngVUweOzE+YXEMob/UWofIdHjvM/6tHBywH2/ZJTKWafEAzT1do1GNw==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr4248660wme.140.1600171145065;
        Tue, 15 Sep 2020 04:59:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a17sm27983502wra.24.2020.09.15.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:59:04 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:59:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v1 13/18] asm-generic/hyperv: introduce hv_device_id
 and auxiliary structures
Message-ID: <20200915115903.yxrj6ay4pvcn42vz@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-5-wei.liu@kernel.org>
 <87k0wvjnmc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0wvjnmc.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 01:16:59PM +0200, Vitaly Kuznetsov wrote:
[...]
> > +union hv_device_id {
> > +	u64 as_uint64;
> > +
> > +	struct {
> > +		u64 :62;
> > +		u64 device_type:2;
> > +	};
> > +
> > +	// HV_DEVICE_TYPE_LOGICAL
> 
> Nit: please no '//' comments.
> 

Fixed. Thanks.

Wei.
