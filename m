Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060C5A5F3C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiH3JWE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiH3JVS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 05:21:18 -0400
X-Greylist: delayed 4800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 02:20:54 PDT
Received: from forward503o.mail.yandex.net (forward503o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD07DB7F4
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 02:20:53 -0700 (PDT)
Received: from vla1-ef285479e348.qloud-c.yandex.net (vla1-ef285479e348.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:35a1:0:640:ef28:5479])
        by forward503o.mail.yandex.net (Yandex) with ESMTP id A91CD5C485C;
        Tue, 30 Aug 2022 12:20:50 +0300 (MSK)
Received: by vla1-ef285479e348.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id DEImCeimEC-KnhO3vEJ;
        Tue, 30 Aug 2022 12:20:49 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=mail; t=1661851249;
        bh=ySfz/LY99LFzaToppHOlG1ynyDBOH7D7JAMHAIQZI1I=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=b+JiionGVRrdT+/2QLu+NMGmwqM1bQo7yVVFoEBNF+YNobos7Uc3v6r5SUEKk0/DP
         gtjSrAcwCl9Ycl0dnLEjya1Y/gB56aS2f1jCO9D1F5OQLoFZi3tH/yX93Af3lbYbDf
         okX3/akvLqu1DfHIkoDa3IyBVJLYwSPJC+ua608E=
Authentication-Results: vla1-ef285479e348.qloud-c.yandex.net; dkim=pass header.i=@syntacore.com
Message-ID: <adde706e-1d75-8241-fe2d-955035f88f2f@syntacore.com>
Date:   Tue, 30 Aug 2022 12:20:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] riscv: Fix permissions for all mm's during mm init
Content-Language: ru-RU, en-US
To:     Conor.Dooley@microchip.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220830075900.510105-1-vladimir.isaev@syntacore.com>
 <26ec07d5-14ac-f77c-00a7-23ea77ebeef6@microchip.com>
 <6e0aee65-37f4-ffa5-9adc-039ff3085b07@microchip.com>
From:   Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <6e0aee65-37f4-ffa5-9adc-039ff3085b07@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor,

30.08.2022 11:31, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 09:21, Conor.Dooley@microchip.com wrote:

>> What is the appropriate fixes tag for this patch?
> 
> Also, you should run scripts/{checkpatch,get_maintainer}.pl before sending
> your patch - many of the lines in your commit are too long & you did not CC
> any of the maintainers :/
> 
> Hope that helps,
> Conor.
> 

Thanks for the fixes! Sent v2.

Thank you,
Vladimir Isaev
