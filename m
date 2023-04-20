Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADEA6E9F93
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 01:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjDTXFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjDTXEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 19:04:55 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9A1BD8;
        Thu, 20 Apr 2023 16:04:54 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-63b4a64c72bso1406815b3a.0;
        Thu, 20 Apr 2023 16:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031894; x=1684623894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghkMkAHQhgF1SwqPMsGPve5tHwg5WqiPTIsxzwL3I2c=;
        b=XdICJWMsq11rlLygrsWlN84NjUb3lJEZjWtLrmzILj9h/S2Ui8Uh3RkdVh/WyzNUfA
         qg2JEqFnWvROLWZkVqzAFoc4ddkkzpX/jF0U9VAXqk+Yve1iO6fUy+jtjcCuDKVT2F0d
         bAvOKRv2ByShSfokfK+HB9wXhkkiGwncseFRyEVuF894Ik9ye4ZJ6gMKyf6D0I6nxrzO
         klHQz2sG/KSmC7fzKBPZvmlimqbWq2b7G2pw6/lqJtRKZoC1Ti45SEET0LdtRhkXZXdR
         QmN+UVNjbyeYllkcemiK+j1oBTF51GQKvcrvYtiGbPulS2rTRS3jg/omaScZiHJ2WutM
         ii9Q==
X-Gm-Message-State: AAQBX9cikfLQwDkoQM1JN5u4cgORplDseH4nfH/tKRYUhVx6sGqfijcQ
        mXL9Do6/Xwc4yjt9G7GH+aQ=
X-Google-Smtp-Source: AKy350biaSJO+8Jw7M71HcF81e70JHBgVdp2pEeW9yMcWLBIdjnsqB4upRiWHcLQkhaHPppO/a4Ifw==
X-Received: by 2002:a05:6a20:a5a8:b0:d3:89a1:76d1 with SMTP id bc40-20020a056a20a5a800b000d389a176d1mr3463522pzb.11.1682031894248;
        Thu, 20 Apr 2023 16:04:54 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id t3-20020a056a00138300b006338e0a9728sm1731215pfg.109.2023.04.20.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 16:04:53 -0700 (PDT)
Date:   Thu, 20 Apr 2023 23:04:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH v4] Drivers: hv: move panic report code from vmbus to hv
 early init code
Message-ID: <ZEHFFKMtxfLSq1fN@liuwe-devbox-debian-v2>
References: <1682030946-6372-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682030946-6372-1-git-send-email-longli@linuxonhyperv.com>
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

On Thu, Apr 20, 2023 at 03:49:06PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> The panic reporting code was added in commit 81b18bce48af
> ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
> 
> It was added to the vmbus driver. The panic reporting has no dependence
> on vmbus, and can be enabled at an earlier boot time when Hyper-V is
> initialized.
> 
> This patch moves the panic reporting code out of vmbus. There is no
> functionality changes. During moving, also refactored some cleanup
> functions into hv_kmsg_dump_unregister().
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks. Queued up for hyperv-next.
