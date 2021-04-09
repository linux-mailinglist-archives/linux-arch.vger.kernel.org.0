Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130B0359291
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhDIDJf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 23:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhDIDJe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 23:09:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305CC061764
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 20:09:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a12so3285296pfc.7
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=FqMTU93Mb4VBYmWBa2xwQCeJSoQRjSTY0KwqA8yKLBzbU80L4YLdxutfRcXzPWwQ85
         4VnipuSuKCOjQyzBJR/sofD/eWTYEq0xJzfqojfCVDV09IfYbdrU53yuUlDkInGAcBnC
         RSckyjdC9LYXRL671NZRN0jiv/64YKKar5RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6V7kMAr/qfNsP2NpJNwSvSLsZ0EwZ6E9deTk98f6UM=;
        b=HEy4lkLLQJC4SkNLW0i/wE6Ve8xZ/kdN0+E83RBt+WbRXZfIEbKD8nxkZkDhyyUh1A
         CsDGnzuZJ5G+eWtaH31ok3O4uhah/SxDQtlgPHZN5YmVr66AFTclp5iCjIG8B73TtuvM
         bRBqrkz+3OdPM07V1D5ErsXyb1NWBVwzyXLbV3YqeBS8lvDtfXx2CXfWhC11a6dWT9Cu
         kHUpqCrxHqqMsHwB3aCHbBzVMxSv4ziMmpmVNUgG6QTlDrHFsCnlRJ2xVnzqR4Lay0h9
         x/TYlEZcMgGXFHKMeiBX+Lqc5pt404hGePS978Bj7xi+CmIp3i6gY26exEPnEqyNHKIb
         1QOA==
X-Gm-Message-State: AOAM533CUlMOYN7GyljNFE5rqQirInfsi9Lk0C8TcsA66qw0C7h4ttKV
        nhQIJkvyV2gNkvyRdT2ZrKdztMSXRP979A==
X-Google-Smtp-Source: ABdhPJzk7Zl0O1lLvoWl18AE7wqoq81kr634C0TdGiP11qwod4pzWNf2ghvh6pnXAELrMZto7M9jVw==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr10975475pgs.101.1617937761659;
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm649034pgq.16.2021.04.08.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:09:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/20] kbuild: sh: remove unused install script
Message-ID: <202104082009.D5774EDC4@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-19-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-19-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:17AM +0200, Greg Kroah-Hartman wrote:
> The sh arch has a install.sh script, but no Makefile actually calls it.
> Remove it to keep anyone from accidentally calling it in the future.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
