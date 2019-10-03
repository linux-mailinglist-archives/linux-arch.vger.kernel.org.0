Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F240CB0C7
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfJCVF2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Oct 2019 17:05:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44309 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfJCVF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 17:05:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so2489778pfn.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EiltBEq6njqGNMiV0WVZrSDJVepz/r4bkWK6+Mlhtls=;
        b=h15edSAOeAVO6+isDrz0W6jcs1RlAD347T43CXwfP6aj516mFy9O19/PPmYCkrcFAy
         8ZZDObjG8qPgpYcPLivDmXHq0y38Rv2EarhS2mGFXA16kD4oew1n/UDzu96ifq0sZWd0
         QwgfPrCQlt2u9uAiDHKRaued1dnb7vheuPGGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EiltBEq6njqGNMiV0WVZrSDJVepz/r4bkWK6+Mlhtls=;
        b=Isw/j2eP1ChvoqjaIxvjrgeziWCG6NqfrAtpKxMzKpko35LVzAOQzBMOQ+kP2HBrsM
         gkcXwhKmX3bLzjLhfluitMdIwjaoW0AOnwaI63iqR6tOjGsYEwk9iS5uFYoSa6S8cDet
         JUTGwTynrjZMoTa8lO428Hfh+En3mArelERxiQp5DSabIBe6LuH66FbenyvTRej+yA7w
         bhSu6t3hvui6USRjIFuKaHAXLROl1d5f3pvIrVDuGay9NwpKSh1Hfyz1xoBj8VWJ0GUm
         S0jSOKfmnelKPWsD3muqkdsQU5jom0s5g7K9sqrsg5C+ZA5cuXx078y3RkwtKjexrpLo
         4cyQ==
X-Gm-Message-State: APjAAAU+jvdrqXk+hmIbN9uMh28mssChZ55mZh3sO/eExalFMJFq8udP
        EsKpLKb3y8rvU9u3XcPnudovkA==
X-Google-Smtp-Source: APXvYqwjSuvsL3+nr1PLtA1rKl85DoBCn/uehIlb3OTXV0Cx3UdB9yBzNVCmiNsnR3ZDRn3AOqIfXg==
X-Received: by 2002:a62:3585:: with SMTP id c127mr13074356pfa.18.1570136726099;
        Thu, 03 Oct 2019 14:05:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm5554361pfo.171.2019.10.03.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 14:05:25 -0700 (PDT)
Date:   Thu, 3 Oct 2019 14:05:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [REPOST][RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <201910031404.C30A0F16@keescook>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook>
 <87y2y271ws.fsf@mid.deneb.enyo.de>
 <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 03, 2019 at 03:44:32PM -0500, Eric W. Biederman wrote:
> 
> This system call has been deprecated almost since it was introduced, and none
> of the common distributions enable it.  The only indication that I can find that
> anyone might care is that a few of the defconfigs in the kernel enable it.  However
> that is a small fractions of the defconfigs so I suspect it just a lack of care
> rather than a reflection of software using the the sysctl system call.
> 
> As there appear to be no users of the sysctl system call, remove the
> code so that the proc filesystem can be simplified.

nitpick: line lengths near 80 characters

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

But, yes, I would love to see this gone. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
