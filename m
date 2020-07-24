Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6A122D002
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXUvm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 16:51:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgGXUvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 16:51:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595623899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XI2aWQSLSS2BL+I07xWEF5LRy5zMQpT/YbHu9Qj8EEc=;
        b=fMsEk/8NvSDgOiAp7Z71+flURkvXsVD8muBddBugM8vlXQ2AQqwnXyZIdlWP/rFJBmVGhg
        LbQhV2o7EgZa5s8YlnGERJKcn0d5HBqj5rxISCVnhOMVPwYhWXVxw/Tpop5obULnmVqfTm
        FNF9j1KvABBts6J3XX19wIgDR6ep1yGHJ3wVhCa0LaMhho/OlTveywn6ZrjobqHXlp6YD4
        0jFWY35dzpFPgKzuaFjxKYbkKB2v+qB3iGRpZv/Y7RTaGkTaYySXzG3RQzP0vrC09MKNFw
        0AVYXnE3VMcZkUj4ORIHcuTUelr50E4YkYE9YkYzACtU9sCXFdccF0WKngeUVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595623899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XI2aWQSLSS2BL+I07xWEF5LRy5zMQpT/YbHu9Qj8EEc=;
        b=w3SOL69w8IkUYAClgIDcOFrChb47hjqNSs052rcwx7yOwuVBJeql5dVRBGYjX86U1n1S3y
        7rWYLceqJ9c5IwDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 00/15] entry, x86, kvm: Generic entry/exit functionality for host and guest
In-Reply-To: <20200722215954.464281930@linutronix.de>
References: <20200722215954.464281930@linutronix.de>
Date:   Fri, 24 Jul 2020 22:51:38 +0200
Message-ID: <878sf8tz51.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> This is the 5th version of generic entry/exit functionality for host and
> guest.

I've merged the pile in two steps. Patch 1-5, i.e. the generic code is
here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and merged this branch and patch 6-15 into

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

core/entry is immutable and any updates, changes go on top. It's meant
as a base for other architecture developers who want to fiddle with that
without having to get the x86 mess as well.

Thanks for all the help!

       tglx
