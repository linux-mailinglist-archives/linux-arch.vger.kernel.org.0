Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13715BD3F4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiISRkp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISRko (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 13:40:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1659356E9
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 10:40:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8067330pjq.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2022 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q3x/V3Wzo2201TNAj2ufmzcdKVar0urvOWb7DCMJrbc=;
        b=JP15/uzrx5dVbR5PU42EU1O6DEznL4VmFMyrDXj5AfFUmgAsN8iLtSfyZyTxBQBoKL
         4yD69QhvASn11tMC3o+j8fhGzxawYbZQMsLiPmDN7FQQgh0Zpc5spxrPPESeWj+iOSGE
         baBE86uMCeGMs+m7IjQB1Ax8ooDQlSvRA/8EMLfz9i/jsjhJgJvDxEarCVCD34shaUKQ
         yy01jj4iTG3iMQ6hVAUxBnENrG6uuAd12DC84oS239vcHzAU9oMlpZSJ0dygZOJ1mHNP
         BdoJNZicnh/4BQdkR4tkBWsJGqRqTaPTzC4RbgV8HF6M1eIEfg4i6THP9Nm6XA0F2uDf
         x9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q3x/V3Wzo2201TNAj2ufmzcdKVar0urvOWb7DCMJrbc=;
        b=MnxCgHOKAIARfgyl102v6T2ywf7E4M3pp0cztmaHbgSgpRIOeNNUoJaooMJjk3AaVq
         hujginebJrTaJr2K+9qp9YF0uQ9vZXL+oRVJ73wyTorNRRsS2cGHg1+bOMQqMb5TPvdX
         xRNPpZDZsTOBcPbmLU9n66QoM7F7W60x+v5G0RIOod/C3LbdBbi1Ya7LwNmvm8QP3hx6
         61lf42aFrvN4dzlyC2klXMROCo+zaqmox/oxSdz5BVYi49tb4ad4T2tiJtPb87YrJW2e
         RU48XhYycqBSnXNXH2GPpna5C9SvPZ9FuFQu+QO9NcfLgiSwybNLFr1ywfpRv8Xph5o1
         ungQ==
X-Gm-Message-State: ACrzQf2XAiwFeivrqsy11thHViHZFkOvzMAXn66HepjEARvsXhNDGteg
        SSI1pGl9ryHiL/TOsdQpqOGNqQ==
X-Google-Smtp-Source: AMsMyM56uVMTiyeIq6ccMXx7AYWuS4YDJuuvaPJVtnZ1y2dlmoYuYn9jXTDlh/dWMeOj3v3IuqdfSw==
X-Received: by 2002:a17:903:2649:b0:178:29d8:6d63 with SMTP id je9-20020a170903264900b0017829d86d63mr815715plb.161.1663609243103;
        Mon, 19 Sep 2022 10:40:43 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:a300:cc0::1ac9])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b00176a5767fb0sm21283892pls.94.2022.09.19.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:40:42 -0700 (PDT)
Date:   Mon, 19 Sep 2022 10:40:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Message-ID: <YyiplGhX65Hrkkjw@relinquished.localdomain>
References: <20200428132105.170886-1-hjl.tools@gmail.com>
 <20200428132105.170886-2-hjl.tools@gmail.com>
 <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
 <e15de60c-8133-3d93-eb1c-c6b1b5389887@csgroup.eu>
 <YyimOW229By98Dn7@relinquished.localdomain>
 <Yyin1FUU7enibeD8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyin1FUU7enibeD8@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 06:33:40PM +0100, Mark Brown wrote:
> On Mon, Sep 19, 2022 at 10:26:17AM -0700, Omar Sandoval wrote:
> 
> In general if you're going to CC someone into a thread please put
> a note at the start of your mail explaining why, many of us get
> copied on a lot of irrelevant things for no apparently reason so
> if it's not immediately obvious why we were sent a mail there's
> every chance it'll just be deleted.

Sorry about that.

> > I'm not sure what exactly arch/arm64/include/asm/assembler.h is doing
> > with this file. Perhaps the author, Mark Brown, can clarify?
> 
> I don't understand the question, what file are you talking about
> here?  arch/arm64/include/asm/assembler.h is itself a file and I
> couldn't find anything nearby in your mail talking about a file...

Oops, that was a typo, I meant to say "I'm not sure what
arch/arm64/include/asm/assembler.h is doing with this *note*". To be
more explicit: does ARM64 need .note.gnu.property/NT_GNU_PROPERTY_TYPE_0
in vmlinux?

Thanks,
Omar
