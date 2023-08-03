Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0976DC7E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHCASH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 20:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHCASG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 20:18:06 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB426AB;
        Wed,  2 Aug 2023 17:18:04 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso336356b3a.3;
        Wed, 02 Aug 2023 17:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021884; x=1691626684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl6QX9DmIEcRSeA7Z1ipMoamYcKnhNBiYALRkxXWQ2c=;
        b=Nw7k98uvSlfeMEXRtTW5WwirVACKZArLs8BSCgBxa5Yw9WHX0wrNOeAq49oTc2CEXL
         1L3/w6B9shYUiTELt/mFo8jPT+lkOSCKA8jtLV5+m8/aRvm61NW27qeRrBxTHZ/h1TUi
         kv9kBWarzyyYpldisv8r3pF9EX1f3xUGNWxg34MD2Doj4ZYvCj5TsVWLBvXEK6sNLZI3
         ZA09kanI2DS9qQr8QNGhdAZHkjzmi4Av+cdAOwT22d4ioMKdYyZ33ARiMi8NJzkksEgh
         axDXCbhR9aaA6aBrLMysDEYO7JmJy4eq2W3T6CmFypDe3Zj2MCceK/MBj5XJEYHoYB28
         56oA==
X-Gm-Message-State: ABy/qLbYGE/2sQHTOrqOMwJxD2KH43j0iJvLPEz0Zfpc0+WzUv7CMxZF
        hKx+q7AqkHKbmS6nA1ehxSUSCvfZ6l4=
X-Google-Smtp-Source: APBJJlF95ql1YXjtX59H4uiRbC0bKPcjVn1nFK62f1myuPyudDMBv4h+vze8rn0coQQDxK1hQO5+oA==
X-Received: by 2002:a05:6a00:1a08:b0:668:81c5:2f8a with SMTP id g8-20020a056a001a0800b0066881c52f8amr19808839pfv.17.1691021883751;
        Wed, 02 Aug 2023 17:18:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b00687260020b1sm7392848pfe.72.2023.08.02.17.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 17:18:02 -0700 (PDT)
Date:   Thu, 3 Aug 2023 00:17:56 +0000
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
Subject: Re: [PATCH 11/15] Drivers: hv: export vmbus_isr, hv_context and
 hv_post_message
Message-ID: <ZMryNGICsouiTfOt@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-12-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690487690-2428-12-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 27, 2023 at 12:54:46PM -0700, Nuno Das Neves wrote:
> These will be used by the mshv_vtl driver.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
