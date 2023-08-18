Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D5D7815D4
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbjHRXbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbjHRXbL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:31:11 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E6E4C;
        Fri, 18 Aug 2023 16:31:10 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bc0d39b52cso11320905ad.2;
        Fri, 18 Aug 2023 16:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401470; x=1693006270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0VrumJjXJtBH0MCiqRAB25wxy5fETy8C315CEQSkOI=;
        b=O1uk9GNOIpHfJ4FywIHwXawtEMTIhGkv66O2F+O19NiDM8Ai9qq/Iy/wvlKpLNSX6e
         WAt0yvNTDngqfvQkUf8M+HZjWCdvXLEZsN5IonLj1LYkoxwi1knEcHSvHAbRkVpemGCx
         MWG5CZpJFsHLa6vQW4bd0h4RZnC9QH73CbZ3Le4cQ8rR6AQ0v7crc5CDTlqO5cfZGqQk
         Fw/cnEj4XDmm7K3zS59vZE6z39Hph/lA8YLsYF5SvJ+DZ5S+jODkaZQhbsOvJkgQ+Kei
         xheLgXVOcBu8mxhGVxsSn1Piuw/S5TKycSb7c9am/Oa85P5JPWyofRbnN44wzr1I3BqX
         b1Ww==
X-Gm-Message-State: AOJu0YxyideC79Hx/LAFGz9N3rT3zLfJvOr0V0+PKqo9SI5YHtA+dPju
        I2lmHHwCLxvjHPEVtbWVScA=
X-Google-Smtp-Source: AGHT+IHTQ4leX3gaB2UBapnVqB5I/AgZBLaIfW34OqI1+sD+yGPUlnFWei0O+z0QrwTB+gAkYxdWRw==
X-Received: by 2002:a17:903:11c6:b0:1bb:98a0:b78a with SMTP id q6-20020a17090311c600b001bb98a0b78amr830369plh.18.1692401470267;
        Fri, 18 Aug 2023 16:31:10 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001bb515e6b39sm2273755pll.306.2023.08.18.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:31:09 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:30:52 +0000
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
Subject: Re: [PATCH v2 14/15] asm-generic: hyperv: Use mshv headers
 conditionally. Add asm-generic/hyperv-defs.h
Message-ID: <ZN//LCO3mVzC4gv9@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-15-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-15-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:50PM -0700, Nuno Das Neves wrote:
> Add hyperv-defs.h to replace some inclusions of hyperv-tlfs.h.
> 
> It includes hyperv-tlfs.h or hvhdk.h depending on a compile-time constant
> HV_HYPERV_DEFS which will be defined in the mshv driver.
> 
> This is needed to keep unstable Hyper-V interfaces independent of
> hyperv-tlfs.h. This ensures hvhdk.h replaces hyperv-tlfs.h in the mshv driver,
> even via indirect includes.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
