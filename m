Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42075D2759
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJJKke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 06:40:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfJJKkd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 06:40:33 -0400
Received: from zn.tnic (p200300EC2F0A6300C5CFCA1B921AC096.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:c5cf:ca1b:921a:c096])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F36DC1EC090E;
        Thu, 10 Oct 2019 12:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570704032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CEt4dlsSD6hLNCfpcBv+TItcwaLdbCGmBJwVp0jE52Y=;
        b=Qb/8B0z/8SHuyj10Uu0bnOSkx6C22IC6RH8jC7QFaxkqw3hi2Xw+pMlrCA8MA+lzrMYIcU
        R9HfBVqfZVc3xwG2eY/U2uTDi6H7SnrRP5zX3UjEj5WLx2T+amIhaiF/8q5v2OnnNYowCN
        wASThpmynIcqAkL6VETz3CqvLHX0uuc=
Date:   Thu, 10 Oct 2019 12:40:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/29] vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate
 export of .notes
Message-ID: <20191010104029.GE7658@zn.tnic>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-9-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926175602.33098-9-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 26, 2019 at 10:55:41AM -0700, Kees Cook wrote:
> In preparation for moving NOTES into RO_DATA, this provides a mechanism

s/this provides/provide/ - imperative tone. Check all your commit
messages pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
