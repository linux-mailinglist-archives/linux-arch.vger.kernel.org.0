Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C66E114D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Apr 2023 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjDMPj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Apr 2023 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDMPjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2023 11:39:24 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428E14489;
        Thu, 13 Apr 2023 08:39:23 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l16so8358519wms.1;
        Thu, 13 Apr 2023 08:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400362; x=1683992362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkRhXAvCj2TnJolvkd3T5V7i4tEpo0/nlB8QeEc1jRw=;
        b=iTOOEbcPqZ+CC8XiZzl9aC9LlI8Fck1YXr0ySs7uNEe/iQfzTEv07Q+9g/5NPdNbLf
         Imwny+VkL/4m6lU1haNsgI2qDqssBSn2pmg9jFZdrrGbpA1MA1uQje7NH7WQEtyPIlRY
         BixesQb1mbtlf4oQBStwMORqhgdTkkeDDUEGKeeWv/43GJn2tm7TuzSzsFS41VppWcoz
         aO3/wcDgnp5STL21QShLLSQ22am8VdoEuqlBNNUB6zARIwsohbgE7SIT63l+r6ng5xJw
         hwd6jDFNrPPrLoKNSWRp4Qb68BzBYz1VYx2p2/ivLiza3iAo6uVMUWTxV2cbn8/EadtW
         Xysw==
X-Gm-Message-State: AAQBX9dwBPAhgJcwJHL83rOpjmzs+gpicpIkXoqp5h/egEQq0SHC5v5U
        2DbeUwKbb6YbZFmLDFrL/1I=
X-Google-Smtp-Source: AKy350YBQSIF0AUA1BSyzBHoVj0NOptbM2oIVn93EN6hnhBiZHZlmpiH0jVGTtK8ImKQb7P4pqTIHQ==
X-Received: by 2002:a1c:4c14:0:b0:3f0:9e27:5ba5 with SMTP id z20-20020a1c4c14000000b003f09e275ba5mr2248503wmf.8.1681400361808;
        Thu, 13 Apr 2023 08:39:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b003f034c76e85sm5848128wms.38.2023.04.13.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 08:39:21 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:39:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, arnd@arndb.de,
        tiala@microsoft.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org, jgross@suse.com, mat.jonczyk@o2.pl
Subject: Re: [PATCH v5 1/5] x86/init: Make get/set_rtc_noop() public
Message-ID: <ZDgiJNNoqGbd7YTA@liuwe-devbox-debian-v2>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
 <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
 <ZDdX11GuiTu0uvpW@liuwe-devbox-debian-v2>
 <20230413091942.GCZDfJLq52qXRWXKQQ@fat_crate.local>
 <ZDghCRg+QnmutzcJ@liuwe-devbox-debian-v2>
 <20230413153753.GDZDgh0T5acw2v1KjK@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413153753.GDZDgh0T5acw2v1KjK@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 13, 2023 at 05:37:53PM +0200, Borislav Petkov wrote:
> On Thu, Apr 13, 2023 at 03:34:33PM +0000, Wei Liu wrote:
> > On Thu, Apr 13, 2023 at 11:19:42AM +0200, Borislav Petkov wrote:
> > > On Thu, Apr 13, 2023 at 01:16:07AM +0000, Wei Liu wrote:
> > > > On Mon, Apr 10, 2023 at 10:55:28PM -0700, Saurabh Sengar wrote:
> > > > > Make get/set_rtc_noop() to be public so that they can be used
> > > > > in other modules as well.
> > > > > 
> > > > > Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> > > > > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > > Reviewed-by: Wei Liu <wei.liu@kernel.org>
> > > > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > > 
> > > > x86 maintainers, can you please ack or nack this patch?
> > > 
> > > Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> > 
> > Thank you very much!
> 
> Just a heads up:
> 
> https://git.kernel.org/tip/775d3c514c5b2763a50ab7839026d7561795924d
> 
> and that one is a fix so it'll go to Linus now.
> 
> Which means, you'll have to use Linus' tree with that fix as a base and
> queue everything ontop.

Okay, understood. Thanks.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
