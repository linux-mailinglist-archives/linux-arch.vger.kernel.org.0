Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D79508DC3
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380777AbiDTQya (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiDTQy2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 12:54:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88F3E0CD
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so2305811plk.8
        for <linux-arch@vger.kernel.org>; Wed, 20 Apr 2022 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9+En7kf8cMM4lilm6s+J9uWhGlWcAjQzxaK8L2b/yA=;
        b=YqfTGXkTj7mUMNHl8AR6co6vtH+qL2mZip14QkbPsN4nY07sBa+sTvz1XMbbeyz4AE
         qsMT1ljKJMRiRYNdr5loSuoF+qM7e9zZe2N9noxI5SlSpTHKcpaZ3wLrHTaHd8v7rNf/
         FMCNM7fgNDKr/3l8mkrkZzwqn66Xz1UFPnDU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9+En7kf8cMM4lilm6s+J9uWhGlWcAjQzxaK8L2b/yA=;
        b=2yvR30aQKMsZOI7K3EDv/CIG+ZFgP5XLydiSVyGX3VFPTB6Gdbn2Vand+b5nTbI5ua
         p9YBtvGW2OWwaj0/csVMcLSgMrvPGELPwsvBm55vjVHETOrxceB2Fc/UzKgdcXzMuZLa
         cb+ngGpClrxiSiOY+AWPJQASI+TDh6Dj+SDwWl/XBm0JCO7CDB5RQccNirrXGVigq9Kj
         3QXM8WQaqusEc1bt38xyr/llKSKot64zvbX/xLtgm9I0uOfR2nCLMlbHcFcoTEXyTU2o
         diy8IuFVSvI4yMZDHxw9iHMqGZK7m0qZZd1t8BlKqv2l7o8yqfD5rfET/qEBMTWvlCSw
         UywA==
X-Gm-Message-State: AOAM53338lXbyYqp71EO1EJWB1XPqES55UfP/WCD/7HGrpW24r8xv9+f
        QO6Bu/1siR8OhBSGCnTDLs+Oug==
X-Google-Smtp-Source: ABdhPJzHr7hb1CMb581iKLRjKcnWhaVG0GzBTLI6ORlSb6FQuuY7KCcKgljZRLw4A39xOXvmx3eGYQ==
X-Received: by 2002:a17:90b:33cc:b0:1ce:a3fe:af41 with SMTP id lk12-20020a17090b33cc00b001cea3feaf41mr5502986pjb.229.1650473500753;
        Wed, 20 Apr 2022 09:51:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a001a8600b004fac74c8382sm21286448pfv.47.2022.04.20.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:51:40 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:51:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     will@kernel.org, broonie@kernel.org, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        szabolcs.nagy@arm.com, yu-cheng.yu@intel.com,
        ebiederm@xmission.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH v13 0/2] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <202204200951.68BC793FC3@keescook>
References: <20220419105156.347168-1-broonie@kernel.org>
 <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165043278356.1481705.13924459838445776007.b4-ty@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 19, 2022 at 10:33:06PM -0700, Kees Cook wrote:
> On Tue, 19 Apr 2022 11:51:54 +0100, Mark Brown wrote:
> > Deployments of BTI on arm64 have run into issues interacting with
> > systemd's MemoryDenyWriteExecute feature.  Currently for dynamically
> > linked executables the kernel will only handle architecture specific
> > properties like BTI for the interpreter, the expectation is that the
> > interpreter will then handle any properties on the main executable.
> > For BTI this means remapping the executable segments PROT_EXEC |
> > PROT_BTI.
> > 
> > [...]
> 
> Applied to for-next/execve, thanks!

Now un-applied! :)

-- 
Kees Cook
