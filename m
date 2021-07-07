Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830F13BEFC1
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhGGSr1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhGGSr1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 14:47:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F37CC061574;
        Wed,  7 Jul 2021 11:44:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s6so166104qkc.8;
        Wed, 07 Jul 2021 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K9NP7NLwWkcfALoFIYmgROqgWj6k4wQiI1w4X/3676E=;
        b=qC6cTiUNt4PvLCjzZUC7QC6IC7L+DJAXF5je2GSApBEjhocKpQ0oVD+MNGxfa4ftwS
         02Wk54BymQcPUi/4myEhTbYW4MKlv5vk/DOT3ZP5wfzcTyz9kaIb572KOHmoSPj3oFbk
         zZTpKvURz/5BzV7T64Fhc+i5Izgs0QhwEkJQIFfRXUj0oAO43ZvAi/LZbQQCCnByzfH8
         lbbFbCevoVsobUoDGl4ECgKEFXKRDEA2m6MC+WNUnLLTdyQqqfWvp+p1JY0ljwauSR8K
         Xb5gFqVUg8xblpgk5IevMfky4mVtH1e2snFkAZpmCk2o/AXLfkp4k31DrscLeNjujJuE
         vN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K9NP7NLwWkcfALoFIYmgROqgWj6k4wQiI1w4X/3676E=;
        b=nJgr6SbeXnqYIWLzeDWCRJD6mRA/IY16OTVmnllmxbP9CTsfMf1h8zkNfESjY9ubXq
         0gHvXmZYu0PA+e6tC/CENqgCjnRQYGKhXVQX8nR12JfJyRG/pxyh/pdMIC+l41EGqkI6
         OQNzJZQxoioBkE31Zl3XOjFnkEQOQmJO1dredNO167CJi8Iql/WZXPMLByX3WUOEVNLc
         moOdD3ltmDLhqs+9p3kdscJIkAFH0L5c8+zPUgJOcIIwCxcADYvdN43YGdnkQ3nYu8Dc
         cyrknWMQpVUyYeZl9JQ1zmEl3pXP5+a8g90AO1qOg0bbgf4pC5lvFGmXqi8kl6VfwcZp
         WKRQ==
X-Gm-Message-State: AOAM530CmPeNvwi43IO1rUEpJ5P9T9xlyIA7N/hX0pbiYe5d3WIoLJqN
        /c0RmGOEj05K4IZzkowsOGQ=
X-Google-Smtp-Source: ABdhPJzjmkHNTPtRsEoRcvvh1kDxyaX4Rte6zSR7Famg52nqIPyXOBPMfXU+DhOr8BTyTIn3DjRmdA==
X-Received: by 2002:a05:620a:1aa5:: with SMTP id bl37mr15895887qkb.200.1625683485662;
        Wed, 07 Jul 2021 11:44:45 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id j141sm3789725qke.33.2021.07.07.11.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:44:45 -0700 (PDT)
Date:   Wed, 7 Jul 2021 11:44:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-audit/audit-kernel 
        <reply+ADSN7RXLQ62LNLD2MK5HFHF65GIU3EVBNHHDPMBXHU@reply.github.com>,
        linux-audit/audit-kernel <audit-kernel@noreply.github.com>,
        Mention <mention@noreply.github.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        bobo.shaobowang@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [linux-audit/audit-kernel] BUG: audit_classify_syscall() fails
 to properly handle 64-bit syscalls when executing as 32-bit application on
 ARM (#131)
Message-ID: <YOX2HBSoltXDGuu+@yury-ThinkPad>
References: <linux-audit/audit-kernel/issues/131@github.com>
 <linux-audit/audit-kernel/issues/131/872191450@github.com>
 <YN9V/qM0mxIYXt3h@yury-ThinkPad>
 <mvm7di59gtx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm7di59gtx.fsf@suse.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 05, 2021 at 12:48:42PM +0200, Andreas Schwab wrote:
> On Jul 02 2021, Yury Norov wrote:
> 
> > At least Marvell, Samsung, Huawei, Cisco and Weiyuchen's employer
> > actively use and develop arm64/ilp32.
> 
> This is good to know.  Where can I get the uptodate kernel patches for
> ILP32?
> 
> Andreas.

The latest kernel supported by me is 5.2:
https://github.com/norov/linux/commits/ilp32-5.2

I know about working ports of ILP32 on 5.7 and 5.10, but didn't see
the code and testing results. Hopefully Paul Moore and Weiyuchen will
share more details.

Yury
