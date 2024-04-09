Return-Path: <linux-arch+bounces-3516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419F89D733
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF07B1F23D8F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 10:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFB80BFC;
	Tue,  9 Apr 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efYu5bVZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877580603;
	Tue,  9 Apr 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659417; cv=none; b=BQtt2jbEHOF7fXqlnes588eyJxqIx7zE+OuY4w/Qwp/czr4wY9MxvvXFCqq1qPf6dZ2U2eTq/r19b0IMgBxH9lw88ru0XDZH3bQKLFV2cT9kG9KEnwvWbfCdZfQRBI1bssQFnlZaTkjKmAaOzgFBtnFSdJKFXTPZ0EX5DJ0T+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659417; c=relaxed/simple;
	bh=gjE+I+A0HeyP2PKHxiDJDFFd+6zMneQwATAwAgoiiJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3giiZ63tUWSmNDKRQKCDok8jC+9N+Pjn6z8mDP3KIC/h4Rc5AzAHD9XltAMwVc6ab/C1tqrHjqbttItfVXuSwPuB9QtIYWZWGf57rtZfgyRgCIqJdoanOIMPMcQ2ads2Pxc/r9rZtaI2zuYjXqpiGujumjbjbZqij2Z/2dNYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efYu5bVZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51fd94c0bfso48298966b.2;
        Tue, 09 Apr 2024 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712659414; x=1713264214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCxhJzgdq7JvJJLvU/sGXpXvWKxyivmCeUQolgjSiVk=;
        b=efYu5bVZfSSgDEVn/SZJv/ezaHCVKWZwV3rQjl7lxqWROToS+1E9FlscMFN/X9py/K
         Dn3vkvnpOXqdVBXT4WaiIqBJ9jnBXdSOd3soFZJ5qEJJdYlqiqAh4XC+a1GSbKZuOlUP
         mlMDcp14AsDGO0RJaUwARhxHn83dv32ayleVXI6HSkxgsVB69RYLUIV4BlmV1SjGStry
         5d7L7rRoREVaANSwRosuO0WObWRBmvlnwJ24L/Ih+HbOKVju/xAI7NsU9TVfEXFtGMDG
         hd6bx2wbqjizYA8QOwdmFp58nsyLDdoj421lgl+1CqYyLiqWloozz+STEO09PjuKGQ9w
         oitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712659414; x=1713264214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCxhJzgdq7JvJJLvU/sGXpXvWKxyivmCeUQolgjSiVk=;
        b=MiTNTIWeniuhF/Y8d5k3Jc7hMf09p9RiJXdi1WfTsjTeYh0ysWJtnYbU9aVz4+tHmZ
         R/1K7Z3VQYpuryCvv11VWAZHWGJ+6yF5d1O7tCp0lowEYH7bwKLgkxK9gRTvWDXqsUmV
         9T8MK1rtaW5pMCWAAP78yAOAwCNgLzCJAwjWzRmNUnK2G2XUhRO8ysrrkVD5xHVnU1WS
         HzjojyuBz9vcLH2+z/UMUlVMXoV8dIZRGZYExK+4CQuYlkUESsmn7UF4JR89a2cXoUxq
         fWjgA7MhJungPEs9O+RElApHN1M5fwfms9liiDY8yVY5GogbZ7J9IWNw8bAPjd3twX8e
         iqZA==
X-Forwarded-Encrypted: i=1; AJvYcCXa4tMm98CshDdjNNl4lWHCzMEh0bmmPApixTYq84ZEefXTnX8hZYumAbCSSz5T4xHryau2+FiUiIgC3FJS580YIOYO+MpOZ4N9adVdbl30BghReBM68wiJzkEqZWJ2i2gYbeEC8w==
X-Gm-Message-State: AOJu0Yx1Ma5zJ1dpSeKyFFbVyeGM2LmbYW8uCGS8IoJ6zsMq9QCTM0Tc
	4dT1ihjYKi8Zj6xX7+Eu2TL2cGqFc8ijMyCgkwgWt+2S6oplMoA/fNzrGQboQWM=
X-Google-Smtp-Source: AGHT+IG+aE6wNBav4To09hfvAh5ZkM+dypL331ghgPVgQvN/+5HFswTVM4ecAkY9pRjlPWE16lW81g==
X-Received: by 2002:a17:906:7949:b0:a51:d4fa:cf8f with SMTP id l9-20020a170906794900b00a51d4facf8fmr5027000ejo.6.1712659414226;
        Tue, 09 Apr 2024 03:43:34 -0700 (PDT)
Received: from andrea ([31.189.89.249])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a4628cacad4sm5520411ejc.195.2024.04.09.03.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:43:33 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:43:29 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/3] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <ZhUb0eWvaoogbeaS@andrea>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
 <20240404192649.531112-2-paulmck@kernel.org>
 <Zg/M141yzwnwPbCi@andrea>
 <88b71a34-3d50-40a8-b4b6-c2d29a5d93a5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b71a34-3d50-40a8-b4b6-c2d29a5d93a5@paulmck-laptop>

> Good catch in all four tests, thank you!
> 
> Does the patch shown at the end of this email clear things up for you?

Yes, that'll do it.

  Andrea

