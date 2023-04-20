Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717756E9D42
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDTUdy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDTUdx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 16:33:53 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD941738;
        Thu, 20 Apr 2023 13:33:51 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1a6715ee82fso16703505ad.1;
        Thu, 20 Apr 2023 13:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022831; x=1684614831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMKNwiENu0Z8d5m2/6B+XlbjR/1zkHhIGQjvkFugIEk=;
        b=OiOwlrv4H76cE3UuHcMFFwnFhTfl3nlg8Zct4wGRNNC4IJD6U9y+tl9FPQ0MShDL5X
         +fuzhvgpwpYul5RjG8cZybi5c4GRonhPpi3wan1ej81JOMjaoQ6PxjP77jZWr6cFTqAh
         KBl4fuYVQAR7FucGswSMxSZ+jT8FtXZlj/MQALB1BTDWJSkPuUi2tEWwnB8gfXjGcq7Q
         EJMYIvDnl7wZrEOCEBupGLpaOP24iTsEPUL8W5HteIzfe4+g9z0l85PP0yJ4K3wEDF4V
         eqJz/0y8wVTSTRd1CZjQ2mdTu7hUBVyaai1a8lPi2+UFrcdfMSFSVm2xhkT+ukc2+zhm
         kHZw==
X-Gm-Message-State: AAQBX9dznKReP1XhldhTwm8ITCK3+Raq2qQcvJkLTJplvTgM/PvZ/YnQ
        C45KpWSG2XtSjrm+SXkpnbHqYomlB5E=
X-Google-Smtp-Source: AKy350YUsTXF1Cor9m/QsEgEiYsl3EPk0yikcUcopSiNllUcBRnS/xbmevNlqzlczSsWmYEZtFe2Zw==
X-Received: by 2002:a17:902:e742:b0:1a9:1b4:9fd5 with SMTP id p2-20020a170902e74200b001a901b49fd5mr3131677plf.68.1682022831328;
        Thu, 20 Apr 2023 13:33:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jl16-20020a170903135000b001a216d44440sm1505655plb.200.2023.04.20.13.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:33:50 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:33:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3] Drivers: hv: move panic report code from vmbus to hv
 early init code
Message-ID: <ZEGhrfLBeuZK8Cwu@liuwe-devbox-debian-v2>
References: <1681960046-9502-1-git-send-email-longli@linuxonhyperv.com>
 <PH7PR21MB32635E38640C3719638A7185CE639@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB32635E38640C3719638A7185CE639@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 20, 2023 at 08:22:40PM +0000, Long Li wrote:
> > Subject: [PATCH v3] Drivers: hv: move panic report code from vmbus to hv
> > early init code
> 
> Hi Wei,
> 
> Please discard this patch. It seems there are some other changes not in linux-next.
> 

linux-next was stale due the breakage this and some other patch
introduced. :-)

> I'm rebasing to hyperv-next and will send an updated version.
> 
> Long
