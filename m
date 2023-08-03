Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09376DCA4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHCA1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHCA1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:27:25 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641502D43;
        Wed,  2 Aug 2023 17:27:24 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686be3cbea0so1049778b3a.0;
        Wed, 02 Aug 2023 17:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691022444; x=1691627244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lskf6Kmvdo5rNLLWiPUjd2IE5xw/oTMaLuczEbQhS8=;
        b=PVLlTXrHj2j7G6Oaem5puBWo4sa3zsCsc6ONebulUh1FCWbj+Wih8JoD1s/TQGOTc3
         66xh0gYPpJi8xEdt2q2v6Wd5rxD8RW8z0IZz1PwV5gzPYwtuIqKxocFePZrjvr42iNd/
         O99nV7bHkrpXCKnNKZxf62WcYdfLupAGYJz6M9UyjkgMw7FCqHDHeLIaoLS+7Qpgg9s0
         MPKqlIVjwIkuaONb/JUMu0063jMzyF1U4fVPr5EiCOBzB9DywOlNm8GCIXNvr3fb/mwc
         +hZOIQNGaKaxM6Os+SIQgT+Gxar/owa9N4gLOVRLsmCRZ+KE2/IUYKnywlz7TSVD6lVU
         EN4g==
X-Gm-Message-State: ABy/qLb4A6wRMlhraBMgu0dtgzOAf6DyGgh8pJCwfHAIphUe4nKDWgyS
        b8hUO0tNlk6y1tmaAaYw0/Q=
X-Google-Smtp-Source: APBJJlEGgf2GNwyqWjoX3d9ZyhSdZlkOI2Cv/gkvnCTjPjVifQkmQBFdGpu93sHaitQVjHkSw6jT+w==
X-Received: by 2002:a05:6a20:7f94:b0:13a:3bd6:2530 with SMTP id d20-20020a056a207f9400b0013a3bd62530mr22654337pzj.1.1691022443866;
        Wed, 02 Aug 2023 17:27:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 35-20020a630b23000000b00551df489590sm11855251pgl.12.2023.08.02.17.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:27:23 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:27:17 +0000
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
Subject: Re: [PATCH 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Message-ID: <ZMr0ZVG/YfSywSA0@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-14-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:48PM -0700, Nuno Das Neves wrote:
> Containing hypervisor ABI definitions to use in mshv driver.
> 
> Version numbers for each file:
> hvhdk.h		25212
> hvhdk_mini.h	25294
> hvgdk.h		25125
> hvgdk_mini.h	25294
> 
> These are unstable interfaces and as such must be compiled independently
> from published interfaces found in hyperv-tlfs.h.
> 
> These are in uapi because they will be used in the mshv ioctl API.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
