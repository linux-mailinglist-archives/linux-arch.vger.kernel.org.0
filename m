Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DBD6385
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJNNPM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 09:15:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNPM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Oct 2019 09:15:12 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B2201EC0C84;
        Mon, 14 Oct 2019 15:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571058910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZsxX8+xNyRBUeuKB1QdVmKb+ikPBn938M3krUvBnqcI=;
        b=KAHp44xdWyhTebZCp+anPbzpo0J6L09rDwzjn3kmbOIsdoZcpJCx36saKmcSJ+MO6Ip9Kg
        dhR+a21UgWg257ulfdCy0X6P31B7lsg8YMQM7E0pAu72OAtis/yLsndIZLQlzRbNTAq9hD
        K6ggoLUWti9U6mU6wr/VC0x3GJSTFWM=
Date:   Mon, 14 Oct 2019 15:15:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/28] x86/asm: Annotate relocate_kernel_{32,64}.c
Message-ID: <20191014131501.GB4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-4-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:43PM +0200, Jiri Slaby wrote:
> There are functions in relocate_kernel_{32,64}.c which are not
> annotated. This makes automatic works on them rather hard. So annotate

Restoring from the previous version: s/works/annotations/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
