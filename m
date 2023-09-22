Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15E37AB9A6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIVSx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjIVSx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 14:53:59 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B012A9;
        Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso2189348b3a.0;
        Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408833; x=1696013633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyufS6U3IQklYUt2ci6ahYWNxLqO+WW3OlDCROay6ew=;
        b=sPoFebxaib2U4S8uTXnpB6NMVmZRqy9UEHjVWUAqsh6rxJLQK2p2OmkEyycx/ndPzB
         eNidHC9ht3XKSExPI2A2HQpWmwUIT2DLNpJoxW28c1wC1BfR9GjSS1tGFSQgiQD6iqJY
         pg8b15+HRm/RRymDfCx6murwKlmp0d/AmMZSxhcXa8zVixsPWzFPhQQBznUJSUQeA8b4
         eKpGYH+sJEQ0s8t+yP2XMjvML/iGm4Ne3zRnil+v3WJh0+O+kdAHlWPFwnrKnZfyLCq6
         yv0sJEwa+X/219J4dpB/Wj63UER9mgLcy6CkglMP7P/Mlq46y9LQ+Dy4xP1e9IPTADUd
         jSAQ==
X-Gm-Message-State: AOJu0Yy1QkKPEXzOc8niMIZDxpzmhEU+bZI0I469e0H4u+NWEhtmsxkC
        cyvjY/y8/AV+sy5OvV+87ENRpkxpYPA=
X-Google-Smtp-Source: AGHT+IGOzg9RTsyttQDdVui32fWhrE83yhzu41HT1TK1Q9puqq0koGTP4Espho+J5bs0KrsUPw9zQg==
X-Received: by 2002:a05:6a00:10c8:b0:690:cd6e:8d38 with SMTP id d8-20020a056a0010c800b00690cd6e8d38mr227642pfu.25.1695408833024;
        Fri, 22 Sep 2023 11:53:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id b124-20020a633482000000b00563df2ba23bsm3460692pga.50.2023.09.22.11.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:53:52 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:53:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v3 02/15] mshyperv: Introduce hv_get_hypervisor_version
 function
Message-ID: <ZQ3ilYnlBYaPMXxG@liuwe-devbox-debian-v2>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1695407915-12216-3-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695407915-12216-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 22, 2023 at 11:38:22AM -0700, Nuno Das Neves wrote:
> x86_64 and arm64 implementations to get the hypervisor version
> information. Store these in hv_hypervisor_version_info structure to
> simplify parsing the fields.
> 
> Replace the existing parsing when printing the version numbers at boot.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
