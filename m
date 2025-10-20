Return-Path: <linux-arch+bounces-14239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E81BF3F4B
	for <lists+linux-arch@lfdr.de>; Tue, 21 Oct 2025 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C64EA295
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643692F3C21;
	Mon, 20 Oct 2025 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPX78qam"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41D6BFCE
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000201; cv=none; b=msuiuh6l7EEhHhf2rkp1mnyPOpB9CMVxHzy8CzeqjT1jWndD+P2W5dLSTrn5HPSSpsnBmiGzZuDIQC2h9Z3nqkV92nQbC8a0eCr8Arv45n+yJMWGvyj/FquPDBJpSANJdJcQZTTZ+pF1WrRNu6kVbFbThkYatJfZq1hf0wSs1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000201; c=relaxed/simple;
	bh=AqgTpYLx8CwO8hQnt4Mwj4oe0AK580FEU7XGKrhn/Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NsZacGb28m29hCUwMENrCCxH+5IYV7GgnB/09YlpPDRpWWFN+cam4zBz833oUt+nOkcZmfhn2/FMGBU93SGdG0neXLCHC8WUcBJkeN+N9BPYXyrSKSjAT5CNECRsHojozXOWmc/WpueL8OyuPEdOF3MSzu/su5VxNbWM3CuAj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPX78qam; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4711899ab0aso37971755e9.2
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761000198; x=1761604998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AqgTpYLx8CwO8hQnt4Mwj4oe0AK580FEU7XGKrhn/Po=;
        b=sPX78qamHS1cJ1CyVZIO3TCRtqEyXnSW1XO8mLxAZL15ihSkHeJ6lIIEjQh6KWm3ER
         mO8aG5QL4wWS3wo1i2CKNpy01bCN05ne52ge14mM8oRDQ9zbhbutElwFMZiKZEs7vktL
         f29zxZewa8Q5e2UD19bqovcXZWFmRPWaldn3ew/BfB+MHKT0P94TsHw+tSTj+h3LvsqF
         rmJ4c1dSNPW8KMmb9pYZUFLH0SR4BSVr7t+95MO3XeKKoXP+O4CHnynrj9UthwqhkfxE
         QSSNLFEX1+eqczcvWim4FzNBo0zSMgZQibRDepWdkKgmFr9dq3UCUvI0SGjYNSoQhOV9
         HhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000198; x=1761604998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqgTpYLx8CwO8hQnt4Mwj4oe0AK580FEU7XGKrhn/Po=;
        b=nrFMPZsEggJZw43g74xBOIRTchy0/HZ9vsh7yFoxLEFPIQiSlwy3eTrak1WPVJwWRD
         9UtemddpospKNGwlPqYuiK9CmkHRMnDaNhXlGTKkclW2VaBs0Sj552dGnwV/w+OouF5U
         wTR1zmRiqYJPX2y+8Sg/SjOUgwHHaLE9zHqgZus4DKkn5yxpf3Ee3pANkqaHDcqQFn6/
         Lxwb8SPSAX8Oq5kFVdkmRkzvedA43Dkz+U3ZnbrrNm2PzbGQfPLXNXxlefHIlAzQhqUz
         PpXGdeQYmlSX3FX6YTHtcynbTLGsSw0k5NRWiYlKTZ1mDkbEgihCDsMH32SCL/cdczY1
         yRrg==
X-Forwarded-Encrypted: i=1; AJvYcCXM69CvcvzmZbEUPst5NILJXK5UYou68yyIUbnHW2afwSBTbWnzUMMSiaRzqcG8oJJfO2ZWgr5g4FpU@vger.kernel.org
X-Gm-Message-State: AOJu0YzlrEbMKZwiAo21YfDaXa3FOLmA0AU/MVuxCOXOUXGl9Nj6hN4J
	efU/CZF9MbOJOUTsi7ody0zOpwrl9juVYQA9R98NBqJp1XVQQEAXGEw1F9VvOC4uGJG3VVl/ZCz
	hN+WpvC8GhO2APYlD+g==
X-Google-Smtp-Source: AGHT+IGge7y5ElnicFlN3+NEM1B7QPLLGE3Z15cYGDjK/uvYJ2qkxfQ4JRz7kneBOslFx2scA53r9xy1yTZQK1I=
X-Received: from wmwc7.prod.google.com ([2002:a05:600d:62c7:b0:470:fd92:351d])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:670a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-471179017f3mr91705375e9.21.1761000198080;
 Mon, 20 Oct 2025 15:43:18 -0700 (PDT)
Date: Mon, 20 Oct 2025 22:43:17 +0000
In-Reply-To: <87ikgieiar.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87ikgieiar.fsf@trenco.lwn.net>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251020224317.723069-1-sidnayyar@google.com>
Subject: [PATCH v2 00/10] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: corbet@lwn.net
Cc: arnd@arndb.de, gprocida@google.com, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, maennich@google.com, mcgrof@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, petr.pavlu@suse.com, 
	samitolvanen@google.com, sidnayyar@google.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 13, 2025 at 8:02PM Jonathan Corbet <corbet@lwn.net> wrote:
> Siddharth Nayyar <sidnayyar@google.com> writes:
> > This patch series implements a mechanism for scalable exported symbol
> > flags using a separate section called __kflagstab. The series introduces
> > __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> > simplifies symbol resolution during module loading, and adds symbol
> > import protection.
>
> This caught my eye in passing ... some questions ...
>
> The import protection would appear to be the real point of this work?

Yes, import protection prompted the introduction of __kflagstab. But I
would agrue that __kflagstab in its own right is an improvement to the
overall health of the module loader code, therefore can be taken even
without import protection.

> But it seems that you have kind of buried it; why not describe what you
> are trying to do here and how it will be used?

Point taken. For sake of clarity, import protection is a mechanism which
intends to restrict the use of symbols exported by vmlinux to signed
modules only, i.e. unsigned modules will be unable to use these symbols.
I will ensure this goes into the cover letter for following versions of
the patch series.

> I ask "how it will be used" since you don't provide any way to actually
> mark exports with this new flag. What is the intended usage here?

Patch 09/10 (last hunk) provides a mechanism to enable import protection
for all symbols exported by vmlinux. To summarise, modpost enables
import protection when CONFIG_UNUSED_KSYMS_WHITELIST is set. This
results in all symbols except for the ones mentioned in the whitelist to
be protected from being imported by out-of-tree modules. In other words,
out-of-tree modules can only use symbols mentioned in
CONFIG_UNUSED_KSYMS_WHITELIST, when the config option is set.

I realise I should have documented this behaviour, both in the cover
letter as well as in kernel documentation. I will do so in the following
version of the patch series.

Please share any feedback on the mechnism to enable the mechanism. In my
opinion, CONFIG_UNUSED_KSYMS_WHITELIST has a complementary goal to
import protection and therefore I felt like using the option to enable
import protection. In case this seems to convoluted, I am okay with
introducing an explicit option to enable import protection.

> If I understand things correctly, applying this series will immediately
> result in the inability to load any previously built modules, right?
> That will create a sort of flag day for anybody with out-of-tree modules
> that some may well see as a regression. Is that really the intent?

Unfortunately this series will break all modules which export symbols
since older versions of such modules will not have the kflagstab
section.

Out-of-tree modules which do not export symbols of their own will only
fail to load in case the CONFIG_UNUSED_KSYMS_WHITELIST is set and the
symbols which these modules consume are not present in the whitelist.

Regards,
Siddharth Nayyar

