Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109133505C4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCaRum (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhCaRu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 13:50:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDEC061763
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 10:50:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so1565533pjq.5
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fwPCJ0ln7XiN1Mgyh62R5lYieMyObsTHbG0RZrvRPwE=;
        b=OefcY/8KfUGCvJz0PF4h17nCzx8f0uaNcos4bTKX5FJPltpnno8jfg/iqcQ8GisI2O
         sHzAFk2S5lMRyMS6dPjFOX+nxDw6q0h8Yq+yTa5WONZV88VtK8jwKjKAtVpgtoDF0Mxi
         tENIdh63kVi4PxUTOmbdWQya7sFMLfNIU5yvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fwPCJ0ln7XiN1Mgyh62R5lYieMyObsTHbG0RZrvRPwE=;
        b=CQ5QpqzhQR6Bv+RNVs66vaDCG2D82WQoLGLqqYgwTV5jVQbKy7DTGHkf03XOeETZU9
         qYyRWSuld8INGAIIVLr2L3i9ucuvchq46hDzk+eEH5KMYywWY9Tki+f2BLRSZ64sP1tC
         TSffMBZq8/SSs95HCYEg5oWWrAIDlnsbbTzm9GdrzGrVjeA8jUlev0DKQdyH3MXrnpwp
         jjY6ollUv0gZw4jkKNniUCXf8LaWjImEmH9r0bhExAWGNYBAkrIurE2Tt1y0wNYv8fE5
         5XGKG3q4jrjx8FCCTc2NWb4gsdzQYOSXxBm5OREZnvDHXpUz6Twiy3uJWiW1F2fng9ze
         hGIA==
X-Gm-Message-State: AOAM531ADwD/3Cg4UePg1BnX90nsiFNeE6XFZU9gglkGfBdybEo2MGjT
        XgzS5s8p1FTq3hOXUY1Jyz8Sug==
X-Google-Smtp-Source: ABdhPJxLFRk32S5JAWcjXEQfVNlU3MgfcnfPT07dz6zmQQRJYgHlVguRXJRY5mE9rC3ZM2LThifa9g==
X-Received: by 2002:a17:90a:c918:: with SMTP id v24mr4631376pjt.182.1617213026927;
        Wed, 31 Mar 2021 10:50:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q184sm2905798pfc.78.2021.03.31.10.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 10:50:26 -0700 (PDT)
Date:   Wed, 31 Mar 2021 10:50:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v31 07/12] landlock: Support filesystem access-control
Message-ID: <202103311048.3D4D927961@keescook>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-8-mic@digikod.net>
 <d2764451-8970-6cbd-e2bf-254a42244ffc@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2764451-8970-6cbd-e2bf-254a42244ffc@digikod.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 07:33:50PM +0200, Mickaël Salaün wrote:
> Jann, Kees, are you OK with this patch and the next one?

I don't feel qualified to say it's using the VFS correctly, but given
the extensive testing via gcov and syzkaller, I'm comfortable with it
landing.

I defer to James. :)

-Kees

-- 
Kees Cook
