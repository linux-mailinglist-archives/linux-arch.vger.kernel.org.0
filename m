Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6D29987B
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 22:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgJZVDQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 17:03:16 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42764 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbgJZVDQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 17:03:16 -0400
Received: by mail-ej1-f66.google.com with SMTP id h24so15786240ejg.9;
        Mon, 26 Oct 2020 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x4YhuX0iisDgAsM+KB7XaZtDcwmduQRIETDyGHldEjU=;
        b=dhlcFomiQe2Cw+akZarQWRYDr++5ZEb89CcZI+NOfo9R/UWp964KuYA+8RGOwjPXQ9
         XjqnGpUZDh7cJmgXkxuZ5mQyO3k18jU5mu93Bjl6PbP9JFla//6UGE3cbdZY8ACGUpmC
         l3D4FUgNQhrpgoCeB4exyZ+DisL+nrL1ea6kGVzgT6HGdkjHRklgtw6QknDRzXhM4CoE
         eLLj4uVgqMY6TLkuM0RhaMfmE9i7Hfnd5y06ONZJJPj8867XQpq146Px/oVP5WGMqH5r
         cz92pkwrklXUvWXMOFRqAF2UMK4ia2N9gyokvflA4rIBkman4Ygi4xlykgzyt+XNT4fY
         cJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4YhuX0iisDgAsM+KB7XaZtDcwmduQRIETDyGHldEjU=;
        b=uL9Trj+KuvHk58KDhNb8D95Y0lxVF5SkqE0KHGmOeQlX7NI4YAebE2FLm7lZvS8xs3
         Ptn66KWryEuPORwPEGiDmJIwm6zzP/cjek+miYEYIQkwd6xVBEOLKFr6y13AQKXNa7Qi
         DgQWdff7EaMgH7MjnypbXSTqkdMTlZJDTqnGenuRrXPI5yIjlF5enf0QGfbmUvYGBDvY
         SAqJgu+/nRv5r258Bk5W3ArNa2Fiv+tal+oiA7fQ0PrVrFt5S1TBOGNB2SMGXXlNKgR6
         +C6k0/VEmE+MnatQjIYOaMh4mP1A4EzwPByLc1RHAThjGvle4PioT8HkdoRy6V6+6xDv
         farw==
X-Gm-Message-State: AOAM533ATSSTkdPhUicQzujtWeI5F9LKZOadewOoBtviOEv62uAhy31b
        E3BWQ3KFllT3Y2BSYtXrosk=
X-Google-Smtp-Source: ABdhPJwZN46JVVhEyFSbvph2Bao2c9vtU78bgRVNWxuwUoXmoOwyGiqVXtA1Gre5FyQKkcBTcLMVWQ==
X-Received: by 2002:a17:906:3e91:: with SMTP id a17mr17421048ejj.82.1603746194313;
        Mon, 26 Oct 2020 14:03:14 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:19a8:8f98:6135:ae35])
        by smtp.gmail.com with ESMTPSA id a1sm5862160edk.52.2020.10.26.14.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 14:03:13 -0700 (PDT)
Date:   Mon, 26 Oct 2020 22:03:12 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: percpu: avoid Wshadow warning
Message-ID: <20201026210312.byq3mdo4e2ei6ee2@ltop.local>
References: <20201026155353.3702892-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026155353.3702892-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26, 2020 at 04:53:48PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Nesting macros that use the same local variable names causes
> warnings when building with "make W=2":
> 
> include/asm-generic/percpu.h:117:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]
> include/asm-generic/percpu.h:126:14: warning: declaration of '__ret' shadows a previous local [-Wshadow]
> 
> These are fairly harmless, but since the warning comes from
> a global header, the warning happens every time the headers
> are included, which is fairly annoying.
> 
> Rename the variables to avoid shadowing and shut up the warning.

Looks good to me. Fell free to add my:

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
