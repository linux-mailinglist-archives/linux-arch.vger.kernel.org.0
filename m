Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6131476DBE6
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHCADB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHCADB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:03:01 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB411731;
        Wed,  2 Aug 2023 17:02:59 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686bc261111so277116b3a.3;
        Wed, 02 Aug 2023 17:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691020979; x=1691625779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9CwBqCkJJkFodz0e9zF6rJm2UPzRnIufx2MpQdm96Q=;
        b=B6Us1mQkqu0GIvD01Uv/bZHFDgTDJeI1elr1AJ3cUHDroPLNcwwx8hHdWODAbG9CLf
         mmhsCR8CZr8dT/2pmwzJ5szQh0cJMM77u6UhxR75PwOl3s5ONT+jr86BnQJw/qVGEnst
         9NdEM+Ty9iTCNMWK7QMS7ILemxGMUW7s1laqd1o6lSq2llHkRNTjreYMoxvVyK/pet0t
         47PkXoJWtmso5FBi2++v7tZ79n4J7nUzFWgm2mQB8ew6877Swc7E8UgeeHkvI/yWFNFk
         96GirWp0NX0yDHO0fzEdvSebklwrWnB2D01jW63BRDaq8xzTeZ8LGpz20+3mDh0mJmF1
         scsw==
X-Gm-Message-State: ABy/qLYmlUqb1I2w0TedPijVZzl6Fnm9nivnX1G8IXKcmmmQkIvEvQ2G
        Vte4BFVGJx0LX+ALBzXa3js=
X-Google-Smtp-Source: APBJJlF4/m+JIyqsbWA/RyQRnjYu3pWp5k9gc382/2oDqfRWxzP8LIk8iaLh784YbKWRY5vRe1Kp8w==
X-Received: by 2002:a05:6a20:7da6:b0:138:c:ed04 with SMTP id v38-20020a056a207da600b00138000ced04mr19488645pzj.39.1691020979101;
        Wed, 02 Aug 2023 17:02:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j8-20020a62b608000000b00687790191a2sm1642773pff.58.2023.08.02.17.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:02:58 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:02:52 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
        decui@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 07/15] Drivers: hv: Move hv_call_deposit_pages and
 hv_call_create_vp to common code
Message-ID: <ZMrurNRcshHdpJ9k@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-8-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:42PM -0700, Nuno Das Neves wrote:
> These hypercalls are not arch-specific.
...
> Move them to common code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Pure code movement so:

Acked-by: Wei Liu <wei.liu@kernel.org>
