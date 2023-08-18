Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C17815CE
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbjHRXZW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbjHRXYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:24:51 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6184205;
        Fri, 18 Aug 2023 16:24:50 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-689e8115f8dso1321895b3a.3;
        Fri, 18 Aug 2023 16:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401090; x=1693005890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7NQ83aYIyQxi7gLafpFyrR+b24flZ6QbANwWTmLCvc=;
        b=Oy9RqBvIAn6i7ov0cE2NQhaRRH2Qlq8vhJGBzibUVuboJhoEhe959q8qfRqWTN/JPM
         fveSAqf5EVZ/RztiU+/Dx/Yy/K2dbrsKjnViB/TCoEL7CVyX6sH0aDlVimIgRxr1iJt+
         oFIGlB6BprQ1S30OYrFhWqw/MH7Qg0mbwK7t2DTfhBf8GhgDZYExbZoBIrytWLsVU+pY
         72+vtv5qey0ocCC80HgFT2yi0TH8v30RsQ1nMFML1PIWvyRnhhI0b+49czn8pA+l30OV
         mNaijyBVR3fJTZDOcKHlWo9k2YsEeS3Sxog5I7doDDLyUm/sGLa397qGJC2RQXIANoiK
         XQyg==
X-Gm-Message-State: AOJu0YzK3lTBENUDSjs/g9YEmJ8KFhRXxUHUzvWMFYYygC7WT2jCiwKB
        r6SfHb+xbAiyzJvGizlhrQ4=
X-Google-Smtp-Source: AGHT+IEhwfhB6DQr618hbfaHC/KUNo74Puro/TMirr0jusK9J3sseJ3LnC6RZE3HgIJvtyH7WvqT0Q==
X-Received: by 2002:a05:6a20:13c7:b0:135:293b:9b14 with SMTP id ho7-20020a056a2013c700b00135293b9b14mr587775pzc.55.1692401089779;
        Fri, 18 Aug 2023 16:24:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id o9-20020a639209000000b0056946623d7esm2062591pgd.55.2023.08.18.16.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:24:49 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:24:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2 12/15] Documentation: Reserve ioctl number for mshv
 driver
Message-ID: <ZN/9r7bX47g7rkcf@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-13-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-13-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:48PM -0700, Nuno Das Neves wrote:
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>

Acked-by: Wei Liu <wei.liu@kernel.org>
